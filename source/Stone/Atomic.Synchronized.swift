import Foundation

/// Synchronized protocol encapsulates a group of atomic properties.
public protocol Synchronized
{
    var lock: Lock { get }
}

extension Synchronized
{
    public func atomic<T>(_ block: (Self) throws -> (T)) rethrows -> T {
        return try self.lock.locked({ try block(self) })
    }
}