import Foundation

/// One-time invocation handler.
final public class Once {
    public init() {}

    /// Stores the state atomically.
    private let synchronized: AtomicValue<Bool> = AtomicValue(false)

    /// Checks if the once has been already invoked.
    public var isDone: Bool { return self.synchronized.atomic }

    /// Invokes the block and marks the once as done, including cases when the block throws an error.
    @discardableResult public func `do`(_ block: () throws -> Void) rethrows -> Bool {
        self.synchronized.lock.lock()
        defer { self.synchronized.lock.unlock() }
        if self.synchronized.raw { return false }
        defer { self.synchronized.raw = true }
        try block()
        return true
    }
}
