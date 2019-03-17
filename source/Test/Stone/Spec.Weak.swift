import Foundation
import Nimble
import Quick
import Stone

internal class WeakSpec: Spec {
    override internal func spec() {
        it("must return default value only when optional is none") {
            var number: Int? = 10
            expect(number ??? "no value") == "10"
            number = nil
            expect(number ??? "no value") == "no value"
        }
    }
}

fileprivate class SpecClass {

}
