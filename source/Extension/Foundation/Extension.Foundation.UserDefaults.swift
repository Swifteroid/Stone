import Foundation

/// Represents string key path. All kudos to Ole Begemann – https://oleb.net/blog/2017/01/dictionary-key-paths.
public struct KeyPath
{
    public init(_ segments: [String]) {
        self.segments = segments
    }

    /// Initializes a KeyPath with a string of the form "this.is.a.keypath".
    public init(_ string: String) {
        self.init(string.components(separatedBy: "."))
    }

    public var segments: [String]

    public var isEmpty: Bool { return self.segments.isEmpty }
    public var path: String { return self.segments.joined(separator: ".") }

    /// Strips off the first segment and returns a pair consisting of the first segment and the remaining 
    /// key path. Returns nil if the key path has no self.segments.
    public func behead() -> (head: String, tail: KeyPath)? {
        guard !isEmpty else { return nil }
        var tail: [String] = self.segments
        return (tail.removeFirst(), KeyPath(tail))
    }
}

extension KeyPath: ExpressibleByStringLiteral
{
    public init(stringLiteral value: String) { self.init(value) }
    public init(unicodeScalarLiteral value: String) { self.init(value) }
    public init(extendedGraphemeClusterLiteral value: String) { self.init(value) }
}

extension Dictionary where Key == String
{

    /// Make sure to keep `keyPath` label when using raw strings with this subscript, otherwise it will fall
    /// back to standard subscript and not return the expected result. Note, while setting a value any intermediate
    /// objects that are not dictionaries with string keys will be overwritten in order to set value. Setting `nil` will clear
    /// the dictionary value and not set the actual `nil` on the key, this behavior matched Swift pre 4.2.
    public subscript(keyPath: KeyPath) -> Any? {
        get {
            guard let (head, tail) = keyPath.behead() else { return nil }

            // Return value if reached the end, otherwise go deeper.

            if tail.isEmpty {
                return self[head]
            } else {
                let dictionary = self[head] as? [Key: Any]
                return dictionary?[tail]
            }
        }
        set {
            guard let (head, tail) = keyPath.behead() else { return }

            // Set value if reached the end, otherwise go deeper.

            if tail.isEmpty {
                if newValue == nil {
                    self.removeValue(forKey: head)
                } else {
                    self[head] = newValue as? Value
                }
            } else {
                var dictionary: [Key: Any?] = self[head] as? [Key: Any?] ?? [:]
                dictionary[tail] = newValue
                if dictionary.isEmpty {
                    self.removeValue(forKey: head)
                } else {
                    self[head] = dictionary as? Value
                }
            }
        }
    }

    public subscript(keyPath keyPath: KeyPath) -> Any? {
        get { return self[keyPath] }
        set { self[keyPath] = newValue }
    }
}

extension UserDefaults
{
    public func object(forKeyPath keyPath: String) -> Any? {
        return self[KeyPath(keyPath)]
    }

    public func set(_ value: Any?, forKeyPath keyPath: String) {
        self[KeyPath(keyPath)] = value
    }

    public subscript(keyPath: KeyPath) -> Any? {
        get {
            guard let (head, tail) = keyPath.behead() else { return nil }
            guard !tail.isEmpty else { return self.object(forKey: head) }
            return self.dictionary(forKey: head)?[tail]
        }
        set {
            guard let (head, tail) = keyPath.behead() else { return }
            guard !tail.isEmpty else { return self.set(newValue, forKey: head) }
            var dictionary: [String: Any] = self.dictionary(forKey: head) ?? [:]
            dictionary[tail] = newValue
            if dictionary.isEmpty {
                self.removeObject(forKey: head)
            } else {
                self.set(dictionary, forKey: head)
            }
        }
    }

    /// Exists for explicitness and consistency with dictionary extension.
    public subscript(keyPath keyPath: KeyPath) -> Any? {
        get { return self[keyPath] }
        set { self[keyPath] = newValue }
    }
}