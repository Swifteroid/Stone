import Nimble
import Stone

internal class InjectionTestCase: TestCase
{
    internal func testDependency() {
        let injection: Injection = Injection.default

        injection.add(name: "foo", dependency: Injection.Dependency(definition: { "Foo" }))
        injection.define(name: Name.bar, definition: { NSString(string: "Bar") })
        injection.add(name: "baz", dependency: Injection.Dependency(definition: { 10 }))
        injection.define(name: Name.qux, definition: { NSNumber(value: 10) })

        let foo: NSObject? = injection.get(name: NSString(string: "foo"))
        let bar: AnyObject = try! injection.get(name: Name.bar)
        let baz: Int = try! injection.get(name: "baz")
        let qux: NSNumber = try! injection.get(name: Name.qux)

        expect(foo).toNot(beNil())
        expect(foo is String) == true

        expect(bar).toNot(beNil())
        expect(bar) === (try! injection.get(name: "bar") as String)

        expect(baz).toNot(beNil())
        expect(baz) == (try! injection.get(name: "baz") as Int)
        expect(baz) == (try! injection.get(name: "qux") as Int)

        expect(qux).toNot(beNil())
        expect(qux) == (try! injection.get(name: "qux") as NSNumber)
        expect(qux) == (try! injection.get(name: "baz") as NSNumber)
    }

    internal func testInstance() {
        let foo: Injection = FooInjection.default
        let bar: Injection = BarInjection.default

        expect(foo).toNot(beNil())
        expect(bar).toNot(beNil())
        expect(foo) != bar
    }
}

private class FooInjection: Injection
{
}

private class BarInjection: Injection
{
}

private enum Name: String, CustomStringConvertible
{
    fileprivate var description: String {
        return self.rawValue
    }

    case foo
    case bar
    case baz
    case qux
}