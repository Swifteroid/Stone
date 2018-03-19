import Foundation
import Nimble
import Stone

internal class CGSizeExtensionTestCase: TestCase
{
    internal func testFitting() {
        let size: CGSize = CGSize(width: 100, height: 50)

        expect(size.fitting(aspect: CGSize(width: 200, height: 200))) == CGSize(width: 200, height: 100)
        expect(size.fitting(aspect: CGSize(width: 200, height: 100))) == CGSize(width: 200, height: 100)
        expect(size.fitting(aspect: CGSize(width: 100, height: 200))) == CGSize(width: 100, height: 50)
        expect(size.fitting(aspect: CGSize(width: 0, height: 0))) == CGSize.zero

        expect(size.fitting(width: 200)) == CGSize(width: 200, height: 100)
        expect(size.fitting(height: 200)) == CGSize(width: 400, height: 200)

        expect(size.fitting(aspect: CGSize(width: CGFloat.infinity, height: 200))) == CGSize(width: 400, height: 200)
        expect(size.fitting(aspect: CGSize(width: 200, height: CGFloat.infinity))) == CGSize(width: 200, height: 100)

        expect(CGSize(width: 0, height: 100).fitting(aspect: CGSize(width: 200, height: 200))) == CGSize(width: 0, height: 200)
        expect(CGSize(width: 100, height: 0).fitting(aspect: CGSize(width: 200, height: 200))) == CGSize(width: 200, height: 0)
        expect(CGSize.zero.fitting(aspect: CGSize(width: 200, height: 200))) == CGSize(width: 200, height: 200)
        expect(CGSize.zero.fitting(aspect: CGSize.zero)) == CGSize.zero
    }

    internal func testFilling() {
        let size: CGSize = CGSize(width: 100, height: 50)

        expect(size.filling(aspect: CGSize(width: 200, height: 200))) == CGSize(width: 400, height: 200)
        expect(size.filling(aspect: CGSize(width: 200, height: 100))) == CGSize(width: 200, height: 100)
        expect(size.filling(aspect: CGSize(width: 100, height: 200))) == CGSize(width: 400, height: 200)
        expect(size.filling(aspect: CGSize(width: 0, height: 0))) == CGSize.zero

        expect(size.filling(width: 200)) == CGSize(width: 200, height: 100)
        expect(size.filling(height: 200)) == CGSize(width: 400, height: 200)

        expect(size.filling(aspect: CGSize(width: CGFloat.infinity, height: 200))) == CGSize.infinite
        expect(size.filling(aspect: CGSize(width: 200, height: CGFloat.infinity))) == CGSize.infinite

        expect(CGSize(width: 0, height: 100).filling(aspect: CGSize(width: 200, height: 200))) == CGSize(width: 200, height: CGFloat.infinity)
        expect(CGSize(width: 100, height: 0).filling(aspect: CGSize(width: 200, height: 200))) == CGSize(width: CGFloat.infinity, height: 200)
        expect(CGSize.zero.filling(aspect: CGSize(width: 200, height: 200))) == CGSize(width: 200, height: 200)
        expect(CGSize.zero.filling(aspect: CGSize.zero)) == CGSize.zero
    }
}