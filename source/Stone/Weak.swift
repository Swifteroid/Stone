import Foundation

/// Weak object reference wrapper, works great with collections and other structs which need to store weak value
/// references, but cannot do so directly.
final public class Weak<Reference: AnyObject> {
    public init(_ reference: Reference? = nil) {
        self.reference = reference
    }

    public weak var reference: Reference?
}
