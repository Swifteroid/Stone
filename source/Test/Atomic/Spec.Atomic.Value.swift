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
    }
}