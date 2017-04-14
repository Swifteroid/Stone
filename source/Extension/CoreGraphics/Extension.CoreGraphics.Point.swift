import CoreGraphics

extension CGPoint
{
    public typealias SELF = CGPoint

    public func translate(x: CGFloat, y: CGFloat) -> SELF {
        return CGPoint(x: self.x + x, y: self.y + y)
    }

    public func translate(x: CGFloat) -> SELF {
        return CGPoint(x: self.x + x, y: self.y)
    }

    public func translate(y: CGFloat) -> SELF {
        return CGPoint(x: self.x, y: self.y + y)
    }
}

public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

public func -=(lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs - rhs
}

public func +=(lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs + rhs
}

public func round(_ point: CGPoint) -> CGPoint {
    return CGPoint(x: round(point.x), y: round(point.y))
}