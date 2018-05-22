import CoreGraphics
import Nimble
import Quick
import Stone

internal class CGPointExtensionSpec: Spec
{
    override internal func spec() {
        it("can negate") {
            expect(-CGPoint(x: 1, y: 2)) == CGPoint(x: -1, y: -2)
        }
    }
}