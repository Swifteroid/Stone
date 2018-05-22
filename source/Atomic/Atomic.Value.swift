import Foundation

public protocol AtomicValueProtocol: class
{
    associatedtype Value: Equatable

    /// Raw stored non-atomic value. This is not thread-safe unless manually synchronized.
    var raw: Value { get set }

    var lock: Lock { get }

    /// Optional will set callback, invoked outside the lock.
    var willSet: ((_ newValue: Value, _ oldValue: Value) -> ())? { get }

    /// Optional did set callback, invoked outside the lock only when the newly set value was different.
    var didSet: ((_ newValue: Value, _ oldValue: Value) -> ())? { get }
}

extension AtomicValueProtocol
{
    public var value: Value {
        get { return self.get() }
        set { self.set(newValue) }
    }

    public func get() -> Value {
        return self.lock.atomic { self.raw }
    }

    @discardableResult public func set(_ newValue: Value, if predicate: ((_ oldValue: Value) -> Bool)? = nil) -> Bool {
        self.willSet?(newValue, self.lock.atomic({ self.value }))
        self.lock.lock()

        let oldValue: Value = self.raw
        let didSet: Bool = newValue != oldValue && predicate?(oldValue) ?? true
        if didSet { self.raw = newValue }

        self.lock.unlock()
        if didSet { self.didSet?(newValue, oldValue) }

        return didSet
    }

    @discardableResult public func update(_ block: (_ currentValue: inout Value) -> ()) -> Bool {
        self.lock.lock()

        let didSet: Bool
        let oldValue: Value = self.raw
        var newValue: Value = oldValue

        block(&newValue)
        didSet = newValue != oldValue

        if didSet { self.raw = newValue }

        self.lock.unlock()
        if didSet { self.didSet?(newValue, oldValue) }

        return didSet
    }
}

public class AtomicValue<T: Equatable>
{

    /// - parameter value: Initial value.
    /// - parameter lock: Shared atomic synchronizer, creates own local instance if value is `nil`.
    public init(_ value: T, _ lock: Lock? = nil) {
        self.raw = value
        self.lock = lock ?? Lock()
    }

    public var raw: T
    public let lock: Lock
    public var willSet: ((_ newValue: T, _ oldValue: T) -> ())?
    public var didSet: ((_ newValue: T, _ oldValue: T) -> ())?
}

extension AtomicValue: AtomicValueProtocol
{
    public typealias Value = T
}

public class WeakAtomicValue<T: AnyObject & Equatable>
{

    /// - parameter value: Initial value.
    /// - parameter lock: Shared atomic synchronizer, creates own local instance if value is `nil`.
    public init(_ value: T?, _ lock: Lock? = nil) {
        self.raw = value
        self.lock = lock ?? Lock()
    }

    public weak var raw: T?
    public let lock: Lock
    public var willSet: ((_ newValue: T?, _ oldValue: T?) -> ())?
    public var didSet: ((_ newValue: T?, _ oldValue: T?) -> ())?
}

extension WeakAtomicValue: AtomicValueProtocol
{
    public typealias Value = T?
}