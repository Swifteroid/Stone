import Fakery
import Foundation
import Nimble
import Stone

internal class DictionaryExtensionTestCase: TestCase
{
    internal func testKeyPath() {
        var dict: [String: Any?] = [:]

        dict[KeyPath("foo.bar")] = 1
        expect(dict[keyPath: "foo.bar"] as? Int) == 1
        expect(dict as NSDictionary) == ["foo": ["bar": 1]]

        // Setting empty dictionary should behave as normal, but setting nil with superscript 
        // removes value for key and clears up any empty dictionaries in hierarchy.

        dict[KeyPath("foo.bar")] = [:]
        expect(dict as NSDictionary) == ["foo": ["bar": [:]]]

        dict[KeyPath("foo.bar")] = nil
        expect(dict).to(beEmpty())
    }
}

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
        expect(userDefaults["foo"] as? Int) == 1

        userDefaults["foo.bar"] = 1
        expect(userDefaults["foo"] as? [String: Int]) == ["bar": 1]
        expect(userDefaults["foo.bar"] as? Int) == 1

        userDefaults["foo.bar.baz"] = 1
        expect(userDefaults["foo.bar"] as? [String: Int]) == ["baz": 1]
        expect(userDefaults["foo.bar.baz"] as? Int) == 1

        // Must remove value and cleanup empty dictionaries, because our defaults are empty
        // persistent domain should return nil.

        userDefaults["foo.bar.baz"] = nil
        expect(userDefaults.persistentDomain(forName: suiteName)).to(beNil())
    }
}