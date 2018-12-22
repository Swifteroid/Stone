import Foundation

// http://nshipster.com/associated-objects/
// https://medium.com/@ttikitu/swift-extensions-can-add-stored-properties-92db66bce6cd

public func associatedObject<T>(owner: Any, key: UnsafePointer<UInt8>, initialiser: () -> T) -> T {
    if let association = objc_getAssociatedObject(owner, key) as? T {
        return association
    }
    let association: T = initialiser()
    objc_setAssociatedObject(owner, key, association, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    return association
}

public func associatedObject<T>(owner: Any, set value: T, key: UnsafePointer<UInt8>) {
    objc_setAssociatedObject(owner, key, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
}