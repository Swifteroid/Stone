import Foundation
import Nimble
import Quick
import Stone

internal class AtomicValueSpec: Spec
{
    override internal func spec() {
        it("can set value atomically") {
            let value: AtomicValue<Int> = .init(0)
            DispatchQueue.concurrentPerform(iterations: 1000, execute: { value.atomic = $0 })
        }

        it("can validate newly set values") {
            var willSetCount: Int = 0
            var didSetCount: Int = 0
            let value: AtomicValue<Int> = .init(0, validate: !=, willSet: { _, _ in willSetCount += 1 }, didSet: { _, _ in didSetCount += 1 })

            expect(value.set(1)) == true
            expect(value.set(1)) == false
            expect(willSetCount) == 1
            expect(didSetCount) == 1
        }

        it("must not invoke didSet after willSet if value gets changed") {
            var didSetCount: Int = 0
            let iterations: Int = 1000
            let value: AtomicValue<Int> = AtomicValue(0, willSet: { _, _ in Thread.sleep(forTimeInterval: 1 / 1000) }, didSet: { _, _ in didSetCount += 1 })

            DispatchQueue.concurrentPerform(iterations: iterations, execute: { value.atomic = $0 })

            expect(didSetCount) < iterations
        }

        it("must not deadlock when modifying value within willSet/didSet callbacks") {
            let value: AtomicValue<Int> = AtomicValue(0)

            value.willSet = { new, old in if new == 1 { value.set(0) } }
            value.didSet = { new, old in if new == 2 { value.set(0) } }

            value.atomic = 1
            value.atomic = 2
        }

        it("benchmarks") {

            // This is a questionable case, but I believe when dealing with large structs like arrays and dictionaries it's better to directly update them
            // via `lock.locked` or `synchronized.atomic` methods. With simple structs this probably doesn't matter as much. When function is non modifying the
            // direct access seems faster by a multitude.

            let iterations: Int = 10000
            let synchronized: Synchronized = .init()
            var date: Date
            var t1: TimeInterval
            var t2: TimeInterval
            var t3: TimeInterval
            var t4: TimeInterval

            date = Date()
            DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in synchronized.value.atomic.append(iteration) })
            // DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in _ = synchronized.value.atomic.contains(iteration) })
            DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in _ = synchronized.value.atomic.popFirst() })
            t1 = Date().timeIntervalSince(date)

            date = Date()
            DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in synchronized.value.update({ $0.append(iteration) }) })
            // DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in synchronized.value.update({ _ = $0.contains(iteration) }) })
            DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in synchronized.value.update({ _ = $0.popFirst() }) })
            t2 = Date().timeIntervalSince(date)

            date = Date()
            DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in synchronized.lock.locked({ synchronized.value.raw.append(iteration) }) })
            // DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in synchronized.lock.locked({ _ = synchronized.value.raw.contains(iteration) }) })
            DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in synchronized.lock.locked({ _ = synchronized.value.raw.popFirst() }) })
            t3 = Date().timeIntervalSince(date)

            date = Date()
            DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in synchronized.atomic({ $0.value.raw.append(iteration) }) })
            // DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in synchronized.atomic({ _ = $0.value.raw.contains(iteration) }) })
            DispatchQueue.concurrentPerform(iterations: iterations, execute: { iteration in synchronized.atomic({ _ = $0.value.raw.popFirst() }) })
            t4 = Date().timeIntervalSince(date)

            // Using `synchronized.lock.locked()` is the fastest, using `synchronized.atomic` is nearly as fast. Everything else is a little slower.
            Swift.print(t1, t2, t3, t4)
        }
    }
}

fileprivate struct Synchronized: Stone.Synchronized
{
    fileprivate init() { self.value = AtomicValue([], self.lock) }
    fileprivate let lock: Lock = .init()
    fileprivate let value: AtomicValue<[Int]>
}