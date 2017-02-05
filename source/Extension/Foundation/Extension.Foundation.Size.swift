import Foundation

extension NSSize
{
    public init(length: CGFloat) {
        self.init(width: length, height: length)
    }

    public func aspectFill(_ bounds: CGRect) -> CGRect {
        var bounds: CGRect = bounds
        let widthRatio: CGFloat = bounds.width / self.width
        let heightRatio: CGFloat = bounds.height / self.height

        if widthRatio > heightRatio {
            bounds.origin.y -= (widthRatio * self.height - bounds.size.height) / 2
            bounds.size.height = widthRatio * self.height
        } else if heightRatio > widthRatio {
            bounds.origin.x -= (heightRatio * self.width - bounds.size.width) / 2
            bounds.size.width = heightRatio * self.width
        }

        return bounds
    }

    public func aspectFit(_ bounds: CGRect) -> CGRect {
        var bounds: CGRect = bounds
        let widthRatio: CGFloat = bounds.width / self.width
        let heightRatio: CGFloat = bounds.height / self.height

        if widthRatio < heightRatio {
            bounds.origin.y -= (widthRatio * self.height - bounds.size.height) / 2
            bounds.size.height = widthRatio * self.height
        } else if heightRatio < widthRatio {
            bounds.origin.x -= (heightRatio * self.width - bounds.size.width) / 2
            bounds.size.width = heightRatio * self.width
        }

        return bounds
    }
}

public func +(lhs: NSSize, rhs: NSSize) -> NSSize {
    return NSSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func +(lhs: NSSize, rhs: NSPoint) -> NSSize {
    return NSSize(width: lhs.width + rhs.x, height: lhs.height + rhs.y)
}

public func -(lhs: NSSize, rhs: NSSize) -> NSSize {
    return NSSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func -(lhs: NSSize, rhs: NSPoint) -> NSSize {
    return NSSize(width: lhs.width - rhs.x, height: lhs.height - rhs.y)
}

public func *(lhs: NSSize, rhs: CGFloat) -> NSSize {
    return NSSize(width: lhs.width * rhs, height: lhs.height * rhs)
}

public func /(lhs: NSSize, rhs: CGFloat) -> NSSize {
    return NSSize(width: lhs.width / rhs, height: lhs.height / rhs)
}

public func round(_ size: NSSize) -> NSSize {
    return NSSize(width: round(size.width), height: round(size.height))
}

public func ceil(_ size: NSSize) -> NSSize {
    return NSSize(width: ceil(size.width), height: ceil(size.height))
}