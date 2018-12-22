import Foundation
import Nimble
import Quick
import Stone

internal class CGRectExtensionSpec: Spec
{
    override internal func spec() {
        it("can align") {
            let large: CGRect = CGRect(x: 100, y: 100, width: 100, height: 100)
            let small: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)

            expect(small.aligned(innerLeft: large, margin: 5)) == CGRect(x: 105, y: 0, width: 10, height: 10)
            expect(small.aligned(outerLeft: large, margin: 5)) == CGRect(x: 85, y: 0, width: 10, height: 10)
            expect(small.aligned(innerRight: large, margin: 5)) == CGRect(x: 185, y: 0, width: 10, height: 10)
            expect(small.aligned(outerRight: large, margin: 5)) == CGRect(x: 205, y: 0, width: 10, height: 10)
            expect(small.aligned(innerTop: large, margin: 5)) == CGRect(x: 0, y: 105, width: 10, height: 10)
            expect(small.aligned(outerTop: large, margin: 5)) == CGRect(x: 0, y: 85, width: 10, height: 10)
            expect(small.aligned(innerBottom: large, margin: 5)) == CGRect(x: 0, y: 185, width: 10, height: 10)
            expect(small.aligned(outerBottom: large, margin: 5)) == CGRect(x: 0, y: 205, width: 10, height: 10)

            expect(small.aligned(center: large)) == CGRect(x: 145, y: 145, width: 10, height: 10)

            expect(small.centered(at: CGPoint(x: 100, y: 100))) == CGRect(x: 95, y: 95, width: 10, height: 10)
            expect(small.centered(in: large)) == CGRect(x: 145, y: 145, width: 10, height: 10)
            expect(small.centered(horizontally: large)) == CGRect(x: 145, y: 0, width: 10, height: 10)
            expect(small.centered(vertically: large)) == CGRect(x: 0, y: 145, width: 10, height: 10)
        }

        it("can be contained by another rect") {
            let container: CGRect = CGRect(x: 100, y: 100, width: 100, height: 100)

            expect(container.inset(by: 25).translating(x: -100).contained(in: container)) == CGRect(x: 100, y: 125, width: 50, height: 50)
            expect(container.inset(by: 25).translating(x: 100).contained(in: container)) == CGRect(x: 150, y: 125, width: 50, height: 50)
            expect(container.inset(by: 25).translating(y: -100).contained(in: container)) == CGRect(x: 125, y: 100, width: 50, height: 50)
            expect(container.inset(by: 25).translating(y: 100).contained(in: container)) == CGRect(x: 125, y: 150, width: 50, height: 50)

            expect(container.inset(by: 25).translating(x: -100, y: -100).contained(in: container)) == CGRect(x: 100, y: 100, width: 50, height: 50)
            expect(container.inset(by: 25).translating(x: 100, y: 100).contained(in: container)) == CGRect(x: 150, y: 150, width: 50, height: 50)
        }

        it("can be modified with operators") {
            var rect: CGRect = CGRect(x: -100, y: -100, width: 200, height: 200)

            expect(rect.topLeft) == CGPoint(x: -100, y: -100)
            expect(rect.topRight) == CGPoint(x: 100, y: -100)
            expect(rect.bottomLeft) == CGPoint(x: -100, y: 100)
            expect(rect.bottomRight) == CGPoint(x: 100, y: 100)
            expect(rect.centerLeft) == CGPoint(x: -100, y: 0)
            expect(rect.centerRight) == CGPoint(x: 100, y: 0)
            expect(rect.centerTop) == CGPoint(x: 0, y: -100)
            expect(rect.centerBottom) == CGPoint(x: 0, y: 100)

            rect.topLeft += CGPoint(x: -50, y: -50)
            expect(rect) == CGRect(x: -150, y: -150, width: 250, height: 250)

            rect.topRight += CGPoint(x: 50, y: -50)
            expect(rect) == CGRect(x: -150, y: -200, width: 300, height: 300)

            rect.bottomLeft += CGPoint(x: -50, y: 50)
            expect(rect) == CGRect(x: -200, y: -200, width: 350, height: 350)

            rect.bottomRight += CGPoint(x: 50, y: 50)
            expect(rect) == CGRect(x: -200, y: -200, width: 400, height: 400)

            rect.centerLeft += CGPoint(x: 25, y: -25)
            expect(rect) == CGRect(x: -175, y: -225, width: 375, height: 450)
            rect.centerLeft += CGPoint(x: 25, y: 25)
            expect(rect) == CGRect(x: -150, y: -200, width: 350, height: 400)

            rect.centerRight += CGPoint(x: -25, y: 25)
            expect(rect) == CGRect(x: -150, y: -175, width: 325, height: 350)
            rect.centerRight += CGPoint(x: -25, y: -25)
            expect(rect) == CGRect(x: -150, y: -200, width: 300, height: 400)

            rect.centerTop += CGPoint(x: -25, y: 25)
            expect(rect) == CGRect(x: -175, y: -175, width: 350, height: 375)
            rect.centerTop += CGPoint(x: 25, y: 25)
            expect(rect) == CGRect(x: -150, y: -150, width: 300, height: 350)
        }

        it("can be flipped") {
            expect(CGRect(x: 0, y: 0, width: 30, height: 40).flip(horizontally: CGRect(x: 0, y: 0, width: 300, height: 400))) == CGRect(x: 270, y: 0, width: 30, height: 40)
            expect(CGRect(x: 110, y: 220, width: 30, height: 40).flip(horizontally: CGRect(x: 100, y: 200, width: 300, height: 400))) == CGRect(x: 360, y: 220, width: 30, height: 40)

            expect(CGRect(x: 0, y: 0, width: 30, height: 40).flip(vertically: CGRect(x: 0, y: 0, width: 300, height: 400))) == CGRect(x: 0, y: 360, width: 30, height: 40)
            expect(CGRect(x: 110, y: 220, width: 30, height: 40).flip(vertically: CGRect(x: 100, y: 200, width: 300, height: 400))) == CGRect(x: 110, y: 540, width: 30, height: 40)
        }

        it("can check for horizontal intersection") {
            let rect1: CGRect = CGRect(x: 0, y: 0, width: 100, height: 10)
            let rect2: CGRect = CGRect(x: 50, y: 30, width: 100, height: 10)

            expect(rect1.intersects(rect2)) == false
            expect(rect1.intersects(horizontally: rect2)) == true

            expect(rect2.intersects(rect1)) == false
            expect(rect2.intersects(horizontally: rect1)) == true
        }

        it("can check for vertical intersection") {
            let rect1: CGRect = CGRect(x: 0, y: 0, width: 10, height: 100)
            let rect2: CGRect = CGRect(x: 30, y: 50, width: 10, height: 100)

            expect(rect1.intersects(rect2)) == false
            expect(rect1.intersects(vertically: rect2)) == true

            expect(rect2.intersects(rect1)) == false
            expect(rect2.intersects(vertically: rect1)) == true
        }

        it("can be scaled") {
            let rect: CGRect = CGRect(x: 50, y: 50, width: 100, height: 100)

            expect(rect.scaling(width: 0.5, height: 0.5)) == CGRect(x: 50, y: 50, width: 50, height: 50)
            expect(rect.scaling(width: 2, height: 3)) == CGRect(x: 50, y: 50, width: 200, height: 300)

            expect(rect.scaling(width: 0.5, height: 0.5, pivot: rect.center).center) == rect.center
            expect(rect.scaling(width: 0.5, height: 0.5, pivot: rect.topLeft).topLeft) == rect.topLeft
            expect(rect.scaling(width: 0.5, height: 0.5, pivot: rect.topRight).topRight) == rect.topRight
            expect(rect.scaling(width: 0.5, height: 0.5, pivot: rect.bottomLeft).bottomLeft) == rect.bottomLeft
            expect(rect.scaling(width: 0.5, height: 0.5, pivot: rect.bottomRight).bottomRight) == rect.bottomRight

            expect(rect.scaling(width: 2, height: 2, pivot: rect.center).center) == rect.center
            expect(rect.scaling(width: 2, height: 2, pivot: rect.topLeft).topLeft) == rect.topLeft
            expect(rect.scaling(width: 2, height: 2, pivot: rect.topRight).topRight) == rect.topRight
            expect(rect.scaling(width: 2, height: 2, pivot: rect.bottomLeft).bottomLeft) == rect.bottomLeft
            expect(rect.scaling(width: 2, height: 2, pivot: rect.bottomRight).bottomRight) == rect.bottomRight
        }
    }
}