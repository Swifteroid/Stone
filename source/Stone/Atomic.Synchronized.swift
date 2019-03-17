import Foundation

/// Synchronized protocol encapsulates a group of atomic properties.
///
///     class MyThreadSafeClass
///     {
///         struct Synchronized: Stone.Synchronized
///         {
///             init() { self.array = AtomicValue([], self.lock) }
///             let lock: Lock = .init()
///             let array: AtomicValue<[String]>
///         }
///
///         private let synchronized: Synchronized = .init()
///     }
public protocol Synchronized {
    var lock: Lock { get }
}

extension Synchronized {
    public func atomic<T>(_ block: (Self) throws -> (T)) rethrows -> T {
        return try self.lock.locked({ try block(self) })
    }
}
