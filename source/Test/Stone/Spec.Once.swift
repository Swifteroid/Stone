import Foundation
import Nimble
import Quick
import Stone

internal class OnceSpec: Spec {
    override internal func spec() {
        it("must invoke the block only once") {
            let once = Once()
            expect(once.do({})) == true
            expect(once.do({ fail() })) == false
        }

        it("must become done even if the block fails") {
            let once = Once()
            do { try once.do({ throw Error.spec }) } catch {}
            expect(once.isDone) == true
        }

    }
}

fileprivate enum Error: Swift.Error {
    case spec
}
