import Foundation
import Nimble
import Quick
import Stone

internal class AtomicLockSpec: Spec
{
    override internal func spec() {
        it("can lock and unlock") {
            let lock: Lock = .init()

            DispatchQueue.concurrentPerform(iterations: 1000, execute: { iteration in
                lock.lock()
                Thread.sleep(forTimeInterval: 0.1 / 1000)
                lock.unlock()
            })
        }

        it("can perform atomic block") {
            let lock: Lock = .init()
            var array: [Int] = []

            DispatchQueue.concurrentPerform(iterations: 1000, execute: { iteration in
                lock.atomic({
                    if array.count > 10 {
                        _ = array.popLast()
                    } else {
                        array.append(iteration)
                    }
                })
            })
        }
    }
}