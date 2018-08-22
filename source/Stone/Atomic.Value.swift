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
    func get() -> Value

    /// Atomically sets value with optional predicate block.
    /// - parameter if: Custom predicate block that will check if old value should be updated.
    /// - return: `true` if new value did set, `false` otherwise.
    @discardableResult func set(_ newValue: Value, if predicate: ((_ oldValue: Value) -> Bool)?) -> Bool

    /// Atomically updates value.
    /// - parameter block: Block that receives input value and updates it.
    /// - return: `true` if new value did set, `false` otherwise.
    @discardableResult func update(_ block: (_ currentValue: inout Value) -> ()) -> Bool
}

public extension AtomicValueProtocol
{
    public var atomic: Value {
        get { return self.get() }
        set { self.set(newValue) }
    }

    public func get() -> Value {
        return self.lock.locked { self.raw }
    }

    @discardableResult public func set(_ newValue: Value, if predicate: ((_ oldValue: Value) -> Bool)? = nil) -> Bool {
        return self.update({ if predicate?($0) ?? true { $0 = newValue } })
    }

    @discardableResult fileprivate func update(_ block: (_ currentValue: inout Value) -> (), _ count: UnsafeMutablePointer<UInt64>) -> Bool {
        let lock: Lock = self.lock

        var isLocked = lock.lock()
        defer { lock.unlock(isLocked) }

        // Must use block suffixes thanks to https://bugs.swift.org/browse/SR-7795.
        let validateBlock = self.validate
        let didSetBlock = self.didSet
        let willSetBlock = self.willSet

        let oldCount: UInt64 = count.pointee
        let oldValue: Value = self.raw
        var newValue: Value = oldValue

        block(&newValue)
        if validateBlock?(newValue, oldValue) == false { return false }

        if let willSetBlock = willSetBlock {
            self.lock.unlocked { willSetBlock(newValue, oldValue) }
            if count.pointee != oldCount { return false }
        }

        self.raw = newValue
        count.pointee += 1
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

    @discardableResult public func update(_ block: (_ currentValue: inout Value) -> ()) -> Bool { return self.update(block, self.updateCount) }
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

    @discardableResult public func update(_ block: (_ currentValue: inout Value) -> ()) -> Bool { return self.update(block, self.updateCount) }
}

extension WeakAtomicValue: AtomicValueProtocol
{
    public typealias Value = T?
}