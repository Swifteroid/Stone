import Foundation
import Nimble
import Stone

internal class CGRectExtensionTestCase: TestCase
{
    internal func testAlign() {
        let foo: CGRect = CGRect(x: 100, y: 100, width: 100, height: 100)
        let bar: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)

        expect(bar.aligned(innerLeft: foo, margin: 5)) == CGRect(x: 105, y: 0, width: 10, height: 10)
        expect(bar.aligned(outerLeft: foo, margin: 5)) == CGRect(x: 85, y: 0, width: 10, height: 10)
        expect(bar.aligned(innerRight: foo, margin: 5)) == CGRect(x: 185, y: 0, width: 10, height: 10)
        expect(bar.aligned(outerRight: foo, margin: 5)) == CGRect(x: 205, y: 0, width: 10, height: 10)
        expect(bar.aligned(innerTop: foo, margin: 5)) == CGRect(x: 0, y: 105, width: 10, height: 10)
        expect(bar.aligned(outerTop: foo, margin: 5)) == CGRect(x: 0, y: 85, width: 10, height: 10)
        expect(bar.aligned(innerBottom: foo, margin: 5)) == CGRect(x: 0, y: 185, width: 10, height: 10)
        expect(bar.aligned(outerBottom: foo, margin: 5)) == CGRect(x: 0, y: 205, width: 10, height: 10)

        expect(bar.aligned(center: foo)) == CGRect(x: 145, y: 145, width: 10, height: 10)

        expect(bar.centered(at: CGPoint(x: 100, y: 100))) == CGRect(x: 95, y: 95, width: 10, height: 10)
        expect(bar.centered(in: foo)) == CGRect(x: 145, y: 145, width: 10, height: 10)
        expect(bar.centered(horizontally: foo)) == CGRect(x: 145, y: 0, width: 10, height: 10)
        expect(bar.centered(vertically: foo)) == CGRect(x: 0, y: 145, width: 10, height: 10)
    }

    internal func testContain() {
        let container: CGRect = CGRect(x: 100, y: 100, width: 100, height: 100)

        expect(container.inset(by: 25).translating(x: -100).contained(in: container)) == CGRect(x: 100, y: 125, width: 50, height: 50)
        expect(container.inset(by: 25).translating(x: 100).contained(in: container)) == CGRect(x: 150, y: 125, width: 50, height: 50)
        expect(container.inset(by: 25).translating(y: -100).contained(in: container)) == CGRect(x: 125, y: 100, width: 50, height: 50)
        expect(container.inset(by: 25).translating(y: 100).contained(in: container)) == CGRect(x: 125, y: 150, width: 50, height: 50)

        expect(container.inset(by: 25).translating(x: -100, y: -100).contained(in: container)) == CGRect(x: 100, y: 100, width: 50, height: 50)
        expect(container.inset(by: 25).translating(x: 100, y: 100).contained(in: container)) == CGRect(x: 150, y: 150, width: 50, height: 50)
    }

    internal func testPoints() {
        var rect: CGRect = CGRect(x: -100, y: -100, width: 200, height: 200)

        expect(rect.topLeft) == CGPoint(x: -100, y: -100)
        expect(rect.topRight) == CGPoint(x: 100, y: -100)
        expect(rect.bottomLeft) == CGPoint(x: -100, y: 100)
        expect(rect.bottomRight) == CGPoint(x: 100, y: 100)
        expect(rect.centerLeft) == CGPoint(x: -100, y: 0)
        expect(rect.centerRight) == CGPoint(x: 100, y: 0)
        expect(rect.centerTop) == CGPoint(x: 0, y: -100)
        expect(rect.centerBottom) == CGPoint(x: 0, y: 100)

        rect.topLeft += CGPoint(x: -50, y: -50)
        expect(rect) == CGRect(x: -150, y: -150, width: 250, height: 250)

        rect.topRight += CGPoint(x: 50, y: -50)
        expect(rect) == CGRect(x: -150, y: -200, width: 300, height: 300)

        rect.bottomLeft += CGPoint(x: -50, y: 50)
        expect(rect) == CGRect(x: -200, y: -200, width: 350, height: 350)

        rect.bottomRight += CGPoint(x: 50, y: 50)
        expect(rect) == CGRect(x: -200, y: -200, width: 400, height: 400)

        rect.centerLeft += CGPoint(x: 25, y: -25)
        expect(rect) == CGRect(x: -175, y: -225, width: 375, height: 450)
        rect.centerLeft += CGPoint(x: 25, y: 25)
        expect(rect) == CGRect(x: -150, y: -200, width: 350, height: 400)

        rect.centerRight += CGPoint(x: -25, y: 25)
        expect(rect) == CGRect(x: -150, y: -175, width: 325, height: 350)
        rect.centerRight += CGPoint(x: -25, y: -25)
        expect(rect) == CGRect(x: -150, y: -200, width: 300, height: 400)

        rect.centerTop += CGPoint(x: -25, y: 25)
        expect(rect) == CGRect(x: -175, y: -175, width: 350, height: 375)
        rect.centerTop += CGPoint(x: 25, y: 25)
        expect(rect) == CGRect(x: -150, y: -150, width: 300, height: 350)
    }
}