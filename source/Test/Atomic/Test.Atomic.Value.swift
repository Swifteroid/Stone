import Foundation
import Nimble
import Stone

internal class AtomicValueTestCase: TestCase
{
    internal func test() {
        let lock: Lock = .init()

        DispatchQueue.concurrentPerform(iterations: 1000, execute: { iteration in
            lock.lock()
            Thread.sleep(forTimeInterval: 0.1 / 1000)
            lock.unlock()
        })

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