import Foundation

/// Weak object reference wrapper, works great with collections and other structs which need to store weak value
/// references, but cannot do so directly.
open class Weak<Reference: AnyObject> {
    public init(_ reference: Reference? = nil) {
        self.reference = reference
    }

    open weak var reference: Reference?
}
