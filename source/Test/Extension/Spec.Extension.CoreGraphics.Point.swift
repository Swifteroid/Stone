import CoreGraphics
import Nimble
import Quick
import Stone

internal class CGPointExtensionSpec: Spec
{
    override internal func spec() {
        it("can translate") {
            expect(CGPoint(x: 10, y: 20).translating(x: 30)) == CGPoint(x: 40, y: 20)
            expect(CGPoint(x: 10, y: 20).translating(y: 40)) == CGPoint(x: 10, y: 60)
            expect(CGPoint(x: 10, y: 20).translating(x: 30, y: 40)) == CGPoint(x: 40, y: 60)
            expect(CGPoint(x: 10, y: 20).translating(30)) == CGPoint(x: 40, y: 50)
            expect(CGPoint(x: 10, y: 20).translating(CGPoint(x: 30, y: 40))) == CGPoint(x: 40, y: 60)
            expect(CGPoint(x: 10, y: 20).translating(distance: sqrt(30 * 30 + 40 * 40), angle: atan(40 / 30))) == CGPoint(x: 40, y: 60)
        }

        it("can negate") {
            expect(-CGPoint(x: 1, y: 2)) == CGPoint(x: -1, y: -2)
        }
    }
}