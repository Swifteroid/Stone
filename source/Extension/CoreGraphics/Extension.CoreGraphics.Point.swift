import CoreGraphics

extension CGPoint
{
    public mutating func translate(x: CGFloat, y: CGFloat) -> CGPoint {
        self.x += x
        self.y += y
        return self
    }

    public mutating func translate(x: CGFloat) -> CGPoint {
        self.x += x
        return self
    }

    public mutating func translate(y: CGFloat) -> CGPoint {
        self.y += y
        return self
    }

    public func translating(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }

    public func translating(x: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y)
    }

    public func translating(y: CGFloat) -> CGPoint {
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