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
        expect(array) == [0, 1, 2, 2, 3, 3, 3, 4, 5]
        expect(removed as? [Int]) == [2]

        array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
        removed = array.remove(element: 2)
        expect(array) == [0, 1, 3, 3, 3, 4, 5]
        expect(removed as? [Int]) == [2, 2, 2]

        array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
        removed = array.remove(elements: [2, 3])
        expect(array) == [0, 1, 4, 5]
        expect(removed as? [Int]) == [2, 2, 2, 3, 3, 3]

        array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
        removed = array.removeFirst(where: { $0 == 2 })
        expect(array) == [0, 1, 2, 2, 3, 3, 3, 4, 5]
        expect(removed as? Int) == 2
    }

    internal func testStringExtension() {
        expect("foo".uppercasedFirst()) == "Foo"
        expect("Foo".lowercasedFirst()) == "foo"
    }
}