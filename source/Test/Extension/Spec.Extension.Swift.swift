import Foundation
import Nimble
import Quick
import Stone

internal class SwiftArrayExtensionSpec: Spec
{
    override internal func spec() {
        it("can remove element by value") {
            var array: [Int]
            var removed: [Int]

            array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
            removed = array.remove(element: 2, first: true)
            expect(array) == [0, 1, 2, 2, 3, 3, 3, 4, 5]
            expect(removed) == [2]

            array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
            removed = array.remove(element: 2)
            expect(array) == [0, 1, 3, 3, 3, 4, 5]
            expect(removed) == [2, 2, 2]

            array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
            removed = array.remove(elements: [2, 3])
            expect(array) == [0, 1, 4, 5]
            expect(removed) == [2, 2, 2, 3, 3, 3]
        }

        it("can remove element by predicate") {
            var array: [Int]
            var removed: [Int]

            array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
            removed = array.remove(where: { $0 == 2 })
            expect(array) == [0, 1, 3, 3, 3, 4, 5]
            expect(removed) == [2, 2, 2]

            array = [0, 1, 2, 2, 2, 3, 3, 3, 4, 5]
            removed = array.remove(where: { $0 == 2 }, first: true)
            expect(array) == [0, 1, 2, 2, 3, 3, 3, 4, 5]
            expect(removed) == [2]
        }
    }
}

internal class SwiftStringExtensionSpec: Spec
{
    override internal func spec() {
        it("can be upper- and lower-cased") {
            expect("foo".uppercasedFirst()) == "Foo"
            expect("Foo".lowercasedFirst()) == "foo"
        }
    }
}