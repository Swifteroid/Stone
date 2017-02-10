import Nimble
import Stone

open class InjectionTestCase: TestCase
{
    open func testDependency() {
        let injection: Injection = Injection.instance

        injection.add(name: "foo", dependency: Injection.Dependency(definition: { NSString(string: "Foo") }))
        injection.define(name: "bar", definition: { NSString(string: "Bar") })

        let bar: AnyObject? = try! injection.get(name: "bar") as NSString
        let foo: AnyObject? = try! injection.get(name: "foo") as NSString

        expect(foo).toNot(beNil())
        expect(foo).to(beIdenticalTo(try! injection.get(name: "foo") as NSString))

        expect(bar).toNot(beNil())
        expect(bar).to(beIdenticalTo(try! injection.get(name: "bar") as NSString))
    }

    open func testInstance() {
        let foo: Injection = FooInjection.instance
        let bar: Injection = BarInjection.instance

        expect(foo).toNot(beNil())
        expect(bar).toNot(beNil())
        expect(foo).toNot(equal(bar))
    }
}

private class FooInjection: Injection
{
}

private class BarInjection: Injection
{
}