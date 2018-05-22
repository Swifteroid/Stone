import Fakery
import Foundation
import Nimble
import Quick
import Stone

internal class FileManagerExtensionSpec: Spec
{
    override internal func spec() {
        it("can assure directory exists") {
            let url: URL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(Faker().lorem.word())
            let manager: FileManager = FileManager.default

            if manager.fileExists(at: url) { try! manager.removeItem(at: url) }
            expect(manager.fileExists(at: url)) == false
            try! manager.assureDirectory(at: url)
            expect(manager.fileExists(at: url)) == true
        }
    }
}