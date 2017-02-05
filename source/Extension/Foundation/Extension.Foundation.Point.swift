import Foundation

extension NSPoint
{
    public typealias SELF = NSPoint

    public func translate(x: CGFloat, y: CGFloat) -> SELF {
        return NSPoint(x: self.x + x, y: self.y + y)
    }

    public func translate(x: CGFloat) -> SELF {
        return NSPoint(x: self.x + x, y: self.y)
    }

    public func translate(y: CGFloat) -> SELF {
        return NSPoint(x: self.x, y: self.y + y)
    }
}

public func +(lhs: NSPoint, rhs: NSPoint) -> NSPoint {
    return NSPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func -(lhs: NSPoint, rhs: NSPoint) -> NSPoint {
    return NSPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func *(lhs: NSPoint, rhs: CGFloat) -> NSPoint {
    return NSPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func /(lhs: NSPoint, rhs: CGFloat) -> NSPoint {
    return NSPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

public func -=(lhs: inout NSPoint, rhs: NSPoint) {
    lhs = lhs - rhs
}

public func +=(lhs: inout NSPoint, rhs: NSPoint) {
    lhs = lhs + rhs
}

public func round(_ point: NSPoint) -> NSPoint {
    return NSPoint(x: round(point.x), y: round(point.y))
}