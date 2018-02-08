import CoreGraphics
import Nimble
import Stone

internal class CGPointExtensionTestCase: TestCase
{
    internal func test() {
        expect(-CGPoint(x: 1, y: 2)).to(equal(CGPoint(x: -1, y: -2)))
    }
}