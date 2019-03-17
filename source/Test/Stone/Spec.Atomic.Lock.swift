import Foundation
import Nimble
import Quick
import Stone

internal class AtomicLockSpec: Spec {
    override internal func spec() {
        it("can lock and unlock") {
            let lock: Lock = Lock()

            DispatchQueue.concurrentPerform(iterations: 1000, execute: { iteration in
                lock.lock()
                Thread.sleep(forTimeInterval: 0.1 / 1000)
                lock.unlock()
            })
        }

        it("can try locking") {
            let lock: Lock = Lock()
            expect(lock.lock()) == true
            expect(lock.try()) == false
        }

        it("can perform atomic block") {
            let lock: Lock = Lock()
            var array: [Int] = []

            DispatchQueue.concurrentPerform(iterations: 1000, execute: { iteration in
                lock.locked {
                    if array.count > 10 {
                        _ = array.popLast()
                    } else {
                        array.append(iteration)
                    }
                }
            })
        }
    }
}
