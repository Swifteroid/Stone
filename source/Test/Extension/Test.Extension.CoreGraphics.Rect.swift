import Foundation
import Nimble
import Stone

internal class CGRectExtensionTestCase: TestCase
{
    internal func testAlign() {
        let foo: CGRect = CGRect(x: 100, y: 100, width: 100, height: 100)
        let bar: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)

        expect(bar.aligned(top: foo)).to(equal(CGRect(x: 0, y: 190, width: 10, height: 10)))
        expect(bar.aligned(bottom: foo)).to(equal(CGRect(x: 0, y: 100, width: 10, height: 10)))
        expect(bar.aligned(left: foo)).to(equal(CGRect(x: 100, y: 0, width: 10, height: 10)))
        expect(bar.aligned(right: foo)).to(equal(CGRect(x: 190, y: 0, width: 10, height: 10)))
        expect(bar.aligned(center: foo)).to(equal(CGRect(x: 145, y: 145, width: 10, height: 10)))

        expect(bar.centered(at: CGPoint(x: 100, y: 100))).to(equal(CGRect(x: 95, y: 95, width: 10, height: 10)))
        expect(bar.centered(in: foo)).to(equal(CGRect(x: 145, y: 145, width: 10, height: 10)))
        expect(bar.centered(horizontally: foo)).to(equal(CGRect(x: 145, y: 0, width: 10, height: 10)))
        expect(bar.centered(vertically: foo)).to(equal(CGRect(x: 0, y: 145, width: 10, height: 10)))
    }

    internal func testPoints() {
        var rect: CGRect = CGRect(x: -100, y: -100, width: 200, height: 200)

        expect(rect.topLeft).to(equal(CGPoint(x: -100, y: -100)))
        expect(rect.topRight).to(equal(CGPoint(x: 100, y: -100)))
        expect(rect.bottomLeft).to(equal(CGPoint(x: -100, y: 100)))
        expect(rect.bottomRight).to(equal(CGPoint(x: 100, y: 100)))
        expect(rect.centerLeft).to(equal(CGPoint(x: -100, y: 0)))
        expect(rect.centerRight).to(equal(CGPoint(x: 100, y: 0)))
        expect(rect.centerTop).to(equal(CGPoint(x: 0, y: -100)))
        expect(rect.centerBottom).to(equal(CGPoint(x: 0, y: 100)))

        rect.topLeft += CGPoint(x: -50, y: -50)
        expect(rect).to(equal(CGRect(x: -150, y: -150, width: 250, height: 250)))

        rect.topRight += CGPoint(x: 50, y: -50)
        expect(rect).to(equal(CGRect(x: -150, y: -200, width: 300, height: 300)))

        rect.bottomLeft += CGPoint(x: -50, y: 50)
        expect(rect).to(equal(CGRect(x: -200, y: -200, width: 350, height: 350)))

        rect.bottomRight += CGPoint(x: 50, y: 50)
        expect(rect).to(equal(CGRect(x: -200, y: -200, width: 400, height: 400)))

        rect.centerLeft += CGPoint(x: 25, y: -25)
        expect(rect).to(equal(CGRect(x: -175, y: -225, width: 375, height: 450)))
        rect.centerLeft += CGPoint(x: 25, y: 25)
        expect(rect).to(equal(CGRect(x: -150, y: -200, width: 350, height: 400)))

        rect.centerRight += CGPoint(x: -25, y: 25)
        expect(rect).to(equal(CGRect(x: -150, y: -175, width: 325, height: 350)))
        rect.centerRight += CGPoint(x: -25, y: -25)
        expect(rect).to(equal(CGRect(x: -150, y: -200, width: 300, height: 400)))

        rect.centerTop += CGPoint(x: -25, y: 25)
        expect(rect).to(equal(CGRect(x: -175, y: -175, width: 350, height: 375)))
        rect.centerTop += CGPoint(x: 25, y: 25)
        expect(rect).to(equal(CGRect(x: -150, y: -150, width: 300, height: 350)))
    }
}