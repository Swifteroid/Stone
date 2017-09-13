import Foundation
import Nimble
import Stone

internal class SwiftExtensionTestCase: TestCase
{
    internal func testArrayRemoveElement() {
        var array: [Int]
        var removed: Any?

        array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
        removed = array.remove(element: 2, first: true)
        expect(array).to(equal([0, 1, 2, 2, 3, 3, 3, 4, 5]))
        expect(removed as? [Int]).to(equal([2]))

        array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
        removed = array.remove(element: 2)
        expect(array).to(equal([0, 1, 3, 3, 3, 4, 5]))
        expect(removed as? [Int]).to(equal([2, 2, 2]))

        array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
        removed = array.remove(elements: [2, 3])
        expect(array).to(equal([0, 1, 4, 5]))
        expect(removed as? [Int]).to(equal([2, 2, 2, 3, 3, 3]))

        array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
        removed = array.removeFirst(where: { $0 == 2 })
        expect(array).to(equal([0, 1, 2, 2, 3, 3, 3, 4, 5]))
        expect(removed as? Int).to(equal(2))
    }
}