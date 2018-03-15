import Fakery
import Foundation
import Nimble
import Stone

internal class FileManagerExtensionTestCase: TestCase
{
    internal func testAssureDirectory() {
        let url: URL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(Faker().lorem.word())
        let manager: FileManager = FileManager.default

        if manager.fileExists(at: url) { try! manager.removeItem(at: url) }
        expect(manager.fileExists(at: url)) == false
        try! manager.assureDirectory(at: url)
        expect(manager.fileExists(at: url)) == true
    }
}