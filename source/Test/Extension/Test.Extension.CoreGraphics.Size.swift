import Foundation
import Nimble
import Stone

internal class CGSizeExtensionTestCase: TestCase
{
    internal func testFittingFilling() {
        let size: CGSize = CGSize(width: 100, height: 50)

        expect(size.filling(aspect: CGSize(width: 200, height: 200))) == CGSize(width: 400, height: 200)
        expect(size.filling(aspect: CGSize(width: 200, height: 100))) == CGSize(width: 200, height: 100)
        expect(size.filling(aspect: CGSize(width: 100, height: 200))) == CGSize(width: 400, height: 200)

        expect(size.fitting(aspect: CGSize(width: 200, height: 200))) == CGSize(width: 200, height: 100)
        expect(size.fitting(aspect: CGSize(width: 200, height: 100))) == CGSize(width: 200, height: 100)
        expect(size.fitting(aspect: CGSize(width: 100, height: 200))) == CGSize(width: 100, height: 50)

        expect(size.fitting(aspect: CGSize(width: CGFloat.infinity, height: 200))) == CGSize(width: 400, height: 200)
        expect(size.fitting(aspect: CGSize(width: 200, height: CGFloat.infinity))) == CGSize(width: 200, height: 100)
        expect(size.filling(aspect: CGSize(width: CGFloat.infinity, height: 200))) == CGSize.infinite
        expect(size.filling(aspect: CGSize(width: 200, height: CGFloat.infinity))) == CGSize.infinite
    }
}