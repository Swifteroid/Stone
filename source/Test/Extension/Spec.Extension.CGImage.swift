import AppKit
import Foundation
import Nimble
import Quick
import Stone

internal class CGImageExtensionSpec: Spec
{
    override internal func spec() {
        it("can be resized") {
            let nsImage: NSImage = Bundle(for: type(of: self)).image(forResource: NSImage.Name("bbb.png"))!
            let cgImage: CGImage = nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil)!
            let originalSize = cgImage.size

            expect(originalSize) == CGSize(width: 640, height: 360)
            expect(cgImage.resize(to: originalSize / 3).size) == round(originalSize / 3)
        }
    }
}