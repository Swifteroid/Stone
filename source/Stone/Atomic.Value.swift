import Foundation

public protocol AtomicValueProtocol: class
{
    associatedtype Value

    /// Raw stored non-atomic value. This is not thread-safe unless manually synchronized. Changing this value directly 
    /// will not invoke `willSet`/`didSet` handlers.
    var raw: Value { get set }

    var lock: Lock { get }

    /// Optional validation block performed to check whether new/updated value should be set. Performed within atomic
    /// lock and therefore must handle deadlock situations.
    var validate: ((_ newValue: Value, _ oldValue: Value) -> Bool)? { get }

    /// Optional will set callback, invoked outside atomic lock. Note, that because it's performed non-atomically it breaks
    /// atomic lock sessions and value might get changed by the time lock is acquired again. In this case value won't be
    /// updated and `set`/`update` method will return `false`. This devalues the whole atomic approach and shouldn't be used
    /// without a good reason. Todo: consider making this atomic and passing lock for custom control.
    var willSet: ((_ newValue: Value, _ oldValue: Value) -> ())? { get }

    /// Optional did set callback, invoked outside atomic lock.
    var didSet: ((_ newValue: Value, _ oldValue: Value) -> ())? { get }

    /// Atomic value.
    var atomic: Value { get set }

    /// Atomically retrieves value.
    func get(lock: Bool) -> Value

    /// Atomically sets value with optional predicate block.
    /// - parameter lock: Indicates whether the update should be locked (atomic), default is `true`. Specify `false` when 
    ///   the value is already locked and atomicity is "manually" guaranteed.
    /// - parameter if: Custom predicate block that will check if old value should be updated.
    /// - return: `true` if new value did set, `false` otherwise.
    @discardableResult func set(_ newValue: Value, lock: Bool, if predicate: ((_ oldValue: Value) -> Bool)?) -> Bool

    /// Atomically updates the value.
    /// - parameter lock: Indicates whether the update should be locked (atomic), default is `true`. Specify `false` when 
    ///   the value is already locked and atomicity is "manually" guaranteed.
    /// - parameter block: Block that receives input value and updates it.
    /// - return: `true` if new value did set, `false` otherwise.
    @discardableResult func update(lock: Bool, _ block: (_ currentValue: inout Value) -> ()) -> Bool
}

public extension AtomicValueProtocol
{
    public var atomic: Value {
        get { return self.get() }
        set { self.set(newValue) }
    }

    public func get(lock: Bool = true) -> Value {
        return lock ? self.lock.locked({ self.raw }) : self.raw
    }

    @discardableResult public func set(_ newValue: Value, lock shouldLock: Bool = true, if predicate: ((_ oldValue: Value) -> Bool)? = nil) -> Bool {
        return self.update(lock: shouldLock, { if predicate?($0) ?? true { $0 = newValue } })
    }

    /// - parameter lock: Indicates whether the update should be locked (atomic), default is `true`. Specify `false` when 
    ///   the value is already locked and atomicity is "manually" guaranteed.
    @discardableResult fileprivate func update(lock shouldLock: Bool = true, counter: UnsafeMutablePointer<UInt64>, _ block: (_ currentValue: inout Value) -> ()) -> Bool {
        let lock: Lock = self.lock

        var isLocked: Bool = shouldLock && lock.lock()
        defer { lock.unlock(isLocked) }

        // Must use block suffixes thanks to https://bugs.swift.org/browse/SR-7795.
        let validateBlock = self.validate
        let didSetBlock = self.didSet
        let willSetBlock = self.willSet

        let oldCount: UInt64 = counter.pointee
        let oldValue: Value = self.raw
        var newValue: Value = oldValue

        block(&newValue)
        if validateBlock?(newValue, oldValue) == false { return false }

        if let willSetBlock = willSetBlock {
            // Todo: Keep an eye on this, this is potentially dangerous – the wording of `lock` parameter is a little wrong, it actually indicates
            // todo: if the value already locked or not…
            lock.unlocked { willSetBlock(newValue, oldValue) }
            if counter.pointee != oldCount { return false }
        }

        self.raw = newValue
        counter.pointee += 1
        lock.unlock(&isLocked)

        didSetBlock?(newValue, oldValue)

        return true
    }
}

final public class AtomicValue<T>
{
    deinit {
        self.updateCount.deinitialize(count: 1)
        self.updateCount.deallocate()
    }

    /// - parameter value: Initial value.
    /// - parameter lock: Shared atomic synchronizer, creates own local instance if value is `nil`.
    public init(_ value: T, _ lock: Lock? = nil, validate: ((_ newValue: T, _ oldValue: T) -> Bool)? = nil, willSet: ((_ newValue: T, _ oldValue: T) -> ())? = nil, didSet: ((_ newValue: T, _ oldValue: T) -> ())? = nil) {
        self.raw = value
        self.lock = lock ?? Lock()
        self.updateCount = UnsafeMutablePointer.allocate(capacity: 1)
        self.updateCount.initialize(to: 0)

        self.validate = validate
        self.willSet = willSet
        self.didSet = didSet
    }

    fileprivate var updateCount: UnsafeMutablePointer<UInt64>

    public var raw: T
    public let lock: Lock

    public var validate: ((_ newValue: T, _ oldValue: T) -> Bool)?
    public var willSet: ((_ newValue: T, _ oldValue: T) -> ())?
    public var didSet: ((_ newValue: T, _ oldValue: T) -> ())?

    @discardableResult public func update(lock shouldLock: Bool = true, _ block: (_ currentValue: inout Value) -> ()) -> Bool { return self.update(lock: shouldLock, counter: self.updateCount, block) }
}

extension AtomicValue: AtomicValueProtocol
{
    public typealias Value = T
}

final public class WeakAtomicValue<T: AnyObject>
{
    deinit {
        self.updateCount.deinitialize(count: 1)
        self.updateCount.deallocate()
    }

    /// - parameter value: Initial value.
    /// - parameter lock: Shared atomic synchronizer, creates own local instance if value is `nil`.
    public init(_ value: T?, _ lock: Lock? = nil, validate: ((_ newValue: T?, _ oldValue: T?) -> Bool)? = nil, willSet: ((_ newValue: T?, _ oldValue: T?) -> ())? = nil, didSet: ((_ newValue: T?, _ oldValue: T?) -> ())? = nil) {
        self.raw = value
        self.lock = lock ?? Lock()
        self.updateCount = UnsafeMutablePointer.allocate(capacity: 1)
        self.updateCount.initialize(to: 0)

        self.validate = validate
        self.willSet = willSet
        self.didSet = didSet
    }

    fileprivate var updateCount: UnsafeMutablePointer<UInt64>

    public weak var raw: T?
    public let lock: Lock

    public var validate: ((_ newValue: T?, _ oldValue: T?) -> Bool)?
    public var willSet: ((_ newValue: T?, _ oldValue: T?) -> ())?
    public var didSet: ((_ newValue: T?, _ oldValue: T?) -> ())?

    @discardableResult public func update(lock shouldLock: Bool = true, _ block: (_ currentValue: inout Value) -> ()) -> Bool { return self.update(lock: shouldLock, counter: self.updateCount, block) }
}

extension WeakAtomicValue: AtomicValueProtocol
{
    public typealias Value = T?
}