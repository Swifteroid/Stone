import CoreGraphics

extension CGSize
{
    public init(length: CGFloat) {
        self.init(width: length, height: length)
    }

    public func fill(aspect bounds: CGRect) -> CGRect {
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

    public func fit(aspect bounds: CGRect) -> CGRect {
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

public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func +(lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize(width: lhs.width + rhs.x, height: lhs.height + rhs.y)
}

public func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func -(lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize(width: lhs.width - rhs.x, height: lhs.height - rhs.y)
}

public func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}

public func /(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
}

public func round(_ size: CGSize) -> CGSize {
    return CGSize(width: round(size.width), height: round(size.height))
}

public func ceil(_ size: CGSize) -> CGSize {
    return CGSize(width: ceil(size.width), height: ceil(size.height))
}