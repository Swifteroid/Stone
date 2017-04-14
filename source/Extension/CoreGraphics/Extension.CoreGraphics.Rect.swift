import CoreGraphics

extension CGRect
{
    public var topLeft: CGPoint { return CGPoint(x: self.minX, y: self.maxY) }
    public var topRight: CGPoint { return CGPoint(x: self.maxX, y: self.maxY) }
    public var bottomLeft: CGPoint { return CGPoint(x: self.minX, y: self.minY) }
    public var bottomRight: CGPoint { return CGPoint(x: self.maxX, y: self.minY) }

    /*
    Centers current rectangle inside the given rectangle.
    */
    public func center(in rectangle: CGRect) -> CGPoint {
        return CGPoint(x: rectangle.origin.x + (rectangle.width - self.width) / 2, y: rectangle.origin.y + (rectangle.height - self.height) / 2)
    }

    /*
    Insets rectangle by a given distance.
    */
    public func inset(by distance: CGFloat) -> CGRect {
        return self.insetBy(dx: distance, dy: distance)
    }

    public init(point point1: CGPoint, point point2: CGPoint) {
        self.init(x: min(point1.x, point2.x), y: min(point1.y, point2.y), width: abs(point2.x - point1.x), height: abs(point2.y - point1.y))
    }

    public func bound(by bounds: CGRect) -> CGRect? {
        return bounds.intersection(self) == CGRect.null ? nil : self - bounds.origin
    }
}

public func +(lhs: CGRect, rhs: CGSize) -> CGRect {
    return CGRect(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func +(lhs: CGRect, rhs: CGPoint) -> CGRect {
    return CGRect(x: lhs.origin.x + rhs.x, y: lhs.origin.y + rhs.y, width: lhs.width, height: lhs.height)
}

public func -(lhs: CGRect, rhs: CGSize) -> CGRect {
    return CGRect(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func -(lhs: CGRect, rhs: CGPoint) -> CGRect {
    return CGRect(x: lhs.origin.x - rhs.x, y: lhs.origin.y - rhs.y, width: lhs.width, height: lhs.height)
}

public func *(lhs: CGRect, rhs: CGFloat) -> CGRect {
    return CGRect(x: lhs.origin.x * rhs, y: lhs.origin.y * rhs, width: lhs.width * rhs, height: lhs.height * rhs)
}

public func /(lhs: CGRect, rhs: CGFloat) -> CGRect {
    return CGRect(x: lhs.origin.x / rhs, y: lhs.origin.y / rhs, width: lhs.width / rhs, height: lhs.height / rhs)
}

public func round(_ rectangle: CGRect) -> CGRect {
    return CGRect(origin: round(rectangle.origin), size: round(rectangle.size))
}