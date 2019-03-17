import Foundation

/// Returning assignment operator to provide a much-missed feature of other languages, where assigned value
/// is returned and can be further operated upon, like `if (x =-> y) == nil { throw Error.nil }`.
infix operator =->: AssignmentPrecedence

public func =-> <T>(oldValue: inout T, newValue: T) -> T {
    oldValue = newValue
    return oldValue
}

/// A custom optional string coalescing operator. All kudos to Ole Bogemann – https://oleb.net/blog/2016/12/optionals-string-interpolation.
infix operator ???: NilCoalescingPrecedence

public func ??? <T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optional {
        case .some(let value): return "\(value)"
        case .none: return defaultValue()
    }
}
