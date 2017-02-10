extension Injection
{
    open class Dependency
    {
        public typealias Definition = () -> Any

        private let definition: Definition

        private var instance: Any?

        // MARK: -

        public init(definition: @escaping Definition) {
            self.definition = definition
        }

        // MARK: -

        open func resolve() -> Any {
            if let instance: Any = self.instance {
                return instance
            }

            let instance: Any = self.definition()

            self.instance = instance

            return instance
        }
    }
}