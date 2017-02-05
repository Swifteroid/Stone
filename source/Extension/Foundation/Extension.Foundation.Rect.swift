import Foundation

extension NSRect
{
    public var topLeft: NSPoint { return NSPoint(x: self.minX, y: self.maxY) }
    public var topRight: NSPoint { return NSPoint(x: self.maxX, y: self.maxY) }
    public var bottomLeft: NSPoint { return NSPoint(x: self.minX, y: self.minY) }
    public var bottomRight: NSPoint { return NSPoint(x: self.maxX, y: self.minY) }

    /*
    Centers current rectangle inside the given rectangle.
    */
    public func center(_ rectangle: NSRect) -> NSPoint {
        return NSPoint(x: rectangle.origin.x + (rectangle.width - self.width) / 2, y: rectangle.origin.y + (rectangle.height - self.height) / 2)
    }

    /*
    Insets rectangle by a given distance.
    */
    public func insetBy(_ distance: CGFloat) -> NSRect {
        return self.insetBy(dx: distance, dy: distance)
    }

    public init(point point1: NSPoint, point point2: NSPoint) {
        self.init(x: min(point1.x, point2.x), y: min(point1.y, point2.y), width: abs(point2.x - point1.x), height: abs(point2.y - point1.y))
    }
}

public func +(lhs: NSRect, rhs: NSSize) -> NSRect {
    return NSRect(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func +(lhs: NSRect, rhs: NSPoint) -> NSRect {
    return NSRect(x: lhs.origin.x + rhs.x, y: lhs.origin.y + rhs.y, width: lhs.width, height: lhs.height)
}

public func -(lhs: NSRect, rhs: NSSize) -> NSRect {
    return NSRect(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func -(lhs: NSRect, rhs: NSPoint) -> NSRect {
    return NSRect(x: lhs.origin.x - rhs.x, y: lhs.origin.y - rhs.y, width: lhs.width, height: lhs.height)
}

public func *(lhs: NSRect, rhs: CGFloat) -> NSRect {
    return NSRect(x: lhs.origin.x * rhs, y: lhs.origin.y * rhs, width: lhs.width * rhs, height: lhs.height * rhs)
}

public func /(lhs: NSRect, rhs: CGFloat) -> NSRect {
    return NSRect(x: lhs.origin.x / rhs, y: lhs.origin.y / rhs, width: lhs.width / rhs, height: lhs.height / rhs)
}

public func round(_ rectangle: NSRect) -> NSRect {
    return NSRect(origin: round(rectangle.origin), size: round(rectangle.size))
}