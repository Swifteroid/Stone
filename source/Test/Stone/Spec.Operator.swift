import Foundation
import Nimble
import Quick
import Stone

internal class OperatorSpec: Spec {
    override internal func spec() {
        context("=-> returning assignment") {
            it("must return newly set value") {
                var foo: String = "foo"
                expect(foo =-> "bar") == "bar"
            }
        }

        context("??? optional string coalescing") {
            it("must return default value only when optional is none") {
                var number: Int? = 10
                expect(number ??? "no value") == "10"
                number = nil
                expect(number ??? "no value") == "no value"
            }
        }
    }
}
