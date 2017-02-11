import Foundation

/*
Must use `@objc` tag and inherit from NSObject to be usable from Objective C inside the bootstrap.
*/
@objc open class Injection: NSObject
{
    private static var instances: [String: Injection] = [:]

    private var dependencies: [String: Dependency] = [:]

    open class var instance: Injection {
        if let instance: Injection = self.instances[String(describing: self)] {
            return instance
        }

        let instance: Injection = self.init()

        self.instances[String(describing: self)] = instance

        return instance
    }

    // MARK: init

    override public required init() {
        super.init()
    }

    // MARK: get

    /*
    Todo: there's a strong temptation to get rid of this, review the rest of the code and decide if it's worth it…
    */
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

    open func get<Name:CustomStringConvertible, Type>(name: Name) throws -> Type {
        return try self.get(name: name.description)
    }

    // MARK: add

    @discardableResult open func add(name: String, dependency: Dependency) -> Self {
        self.dependencies[name] = dependency
        return self
    }

    @discardableResult open func add<Name:CustomStringConvertible>(name: Name, dependency: Dependency) -> Self {
        return self.add(name: name.description, dependency: dependency)
    }

    // MARK: define

    @discardableResult open func define(name: String, definition: @escaping Dependency.Definition) -> Self {
        return self.add(name: name, dependency: Dependency(definition: definition))
    }

    @discardableResult open func define<Name:CustomStringConvertible>(name: Name, definition: @escaping Dependency.Definition) -> Self {
        return self.define(name: name.description, definition: definition)
    }
}

// MARK: -

extension Injection
{
    public enum Error: Swift.Error
    {
        case undefinedDependency(String)
        case uncastableType
    }
}