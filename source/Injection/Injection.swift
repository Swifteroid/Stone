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

    // MARK: -

    override public required init() {
        super.init()
    }

    // MARK: -

    @objc open func get(name: String) -> AnyObject? {
        if let dependency: Dependency = self.dependencies[name] {
            return dependency.resolve() as AnyObject
        } else {
            return nil
        }
    }

    open func get<T>(name: String) throws -> T {
        guard let dependency: Dependency = self.dependencies[name] else {
            throw Error.undefinedDependency(name)
        }

        if let dependency: T = dependency.resolve() as? T {
            return dependency
        } else {
            throw Error.uncastableType
        }
    }

    @discardableResult open func add(name: String, dependency: Dependency) -> Self {
        self.dependencies[name] = dependency
        return self
    }

    @discardableResult open func define(name: String, definition: @escaping Dependency.Definition) -> Self {
        return self.add(name: name, dependency: Dependency(definition: definition))
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