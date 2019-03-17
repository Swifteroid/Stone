import Foundation

private var NSBundleObjectForInfoDictionaryKeyPathCache: UInt8 = 0

extension Bundle {

    /// Was a huge surprise to discovered that even this kind of caching speeds things up nearly x10 times.

    private var objectForInfoDictionaryKeyPathCache: [String: Any?] {
        get {
            return associatedObject(owner: self, key: &NSBundleObjectForInfoDictionaryKeyPathCache, initialiser: { () -> NSDictionary in [String: AnyObject]() as NSDictionary }) as! [String: AnyObject]
        }
        set {
            associatedObject(owner: self, set: newValue as NSDictionary, key: &NSBundleObjectForInfoDictionaryKeyPathCache)
        }
    }

    /// This enables to extract values by period-separated keys.

    public func objectForInfoDictionary<Value>(withKeyPath keyPath: String, cache: Bool = true) -> Value? {
        if cache && self.objectForInfoDictionaryKeyPathCache.index(forKey: keyPath) != nil {
            return objectForInfoDictionaryKeyPathCache[keyPath] as? Value
        } else if let dictionary: NSDictionary = self.infoDictionary as NSDictionary? {
            let value: Any? = dictionary.value(forKeyPath: keyPath)
            if cache {
                self.objectForInfoDictionaryKeyPathCache[keyPath] = value
            }
            return value as? Value
        } else {
            return nil
        }
    }
}
