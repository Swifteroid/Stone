import Foundation

/// Must use `@objc` tag and inherit from NSObject to be usable from Objective C inside the bootstrap.
/// Todo: add subscript support when swift 4 is out to support generics and throwing.

@objc open class Injection: NSObject {
    fileprivate static var defaults: [String: Injection] = [:]

    private var dependencies: [String: Dependency] = [:]

    open class var `default`: Injection! {
        get {
            if self.defaults[String(describing: self)] == nil {
                self.defaults[String(describing: self)] = self.init()
            }
            return self.defaults[String(describing: self)]
        }
        set {
            if let newValue: Injection = newValue {
                self.defaults[String(describing: self)] = newValue
            } else {
                self.defaults.removeValue(forKey: String(describing: self))
            }
        }
    }

    // MARK: -

    override public required init() {
        super.init()
    }

    // MARK: -

    /// This is needed for objc compatibility.

    @objc open func get(name: NSString) -> NSObject? {
        if let dependency: Dependency = self.dependencies[name as String] {
            return dependency.resolve() as? NSObject
        } else {
            return nil
        }
    }

    open func get<Type>(name: String) throws -> Type {
        guard let dependency: Dependency = self.dependencies[name] else {
            throw Error.undefinedDependency(name)
        }

        if let dependency: Type = dependency.resolve() as? Type {
            return dependency
        } else {
            throw Error.uncastableType
        }
    }

    open func get<Type>(name: CustomStringConvertible) throws -> Type {
        return try self.get(name: name.description)
    }

    // MARK: add

    @discardableResult open func add(name: String, dependency: Dependency) -> Self {
        self.dependencies[name] = dependency
        return self
    }

    @discardableResult open func add<Name: CustomStringConvertible>(name: Name, dependency: Dependency) -> Self {
        return self.add(name: name.description, dependency: dependency)
    }

    // MARK: define

    @discardableResult open func define(name: String, definition: @escaping Dependency.Definition) -> Self {
        return self.add(name: name, dependency: Dependency(definition: definition))
    }

    @discardableResult open func define<Name: CustomStringConvertible>(name: Name, definition: @escaping Dependency.Definition) -> Self {
        return self.define(name: name.description, definition: definition)
    }
}

// MARK: -

extension Injection {
    public enum Error: Swift.Error {
        case undefinedDependency(String)
        case uncastableType
    }
}
