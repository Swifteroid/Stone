import Foundation
import Nimble
import Stone

open class CGRectExtensionTestCase: TestCase
{
    open func testAlign() {
        let foo: CGRect = CGRect(x: 100, y: 100, width: 100, height: 100)
        let bar: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)

        expect(bar.align(top: foo)).to(equal(CGRect(x: 0, y: 190, width: 10, height: 10)))
        expect(bar.align(bottom: foo)).to(equal(CGRect(x: 0, y: 100, width: 10, height: 10)))
        expect(bar.align(left: foo)).to(equal(CGRect(x: 100, y: 0, width: 10, height: 10)))
        expect(bar.align(right: foo)).to(equal(CGRect(x: 190, y: 0, width: 10, height: 10)))
        expect(bar.align(center: foo)).to(equal(CGRect(x: 145, y: 145, width: 10, height: 10)))

        expect(bar.center(at: CGPoint(x: 100, y: 100))).to(equal(CGRect(x: 95, y: 95, width: 10, height: 10)))
        expect(bar.center(in: foo)).to(equal(CGRect(x: 145, y: 145, width: 10, height: 10)))
        expect(bar.center(horizontally: foo)).to(equal(CGRect(x: 145, y: 0, width: 10, height: 10)))
        expect(bar.center(vertically: foo)).to(equal(CGRect(x: 0, y: 145, width: 10, height: 10)))
    }
}