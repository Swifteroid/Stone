import Fakery
import Foundation
import Nimble
import Stone

internal class UserDefaultsExtensionTestCase: TestCase
{
    internal func testKeyPath() {
        let suiteName: String = Bundle(for: type(of: self)).bundleIdentifier!
        let userDefaults: UserDefaults = UserDefaults(suiteName: suiteName)!
        userDefaults.removePersistentDomain(forName: suiteName)

        expect(userDefaults["foo"]).to(beNil())
        expect(userDefaults["foo.bar"]).to(beNil())
        expect(userDefaults["foo.bar.baz"]).to(beNil())

        userDefaults["foo"] = 1
        expect(userDefaults["foo"] as? Int).to(equal(1))

        userDefaults["foo.bar"] = 1
        expect(userDefaults["foo"] as? [String: Int]).to(equal(["bar": 1]))
        expect(userDefaults["foo.bar"] as? Int).to(equal(1))

        userDefaults["foo.bar.baz"] = 1
        expect(userDefaults["foo.bar"] as? [String: Int]).to(equal(["baz": 1]))
        expect(userDefaults["foo.bar.baz"] as? Int).to(equal(1))
    }
}