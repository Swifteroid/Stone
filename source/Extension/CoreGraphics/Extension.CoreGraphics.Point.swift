import CoreGraphics

extension CGPoint
{
    public mutating func translate(x: CGFloat) { self.x += x }
    public mutating func translate(y: CGFloat) { self.y += y }
    public mutating func translate(x: CGFloat, y: CGFloat) {
        self.x += x
        self.y += y
    }
    public mutating func translate(_ point: CGPoint) {
        self.x += point.x
        self.y += point.y
    }

    public func translating(x: CGFloat) -> CGPoint { return CGPoint(x: self.x + x, y: self.y) }
    public func translating(y: CGFloat) -> CGPoint { return CGPoint(x: self.x, y: self.y + y) }
    public func translating(x: CGFloat, y: CGFloat) -> CGPoint { return CGPoint(x: self.x + x, y: self.y + y) }
    public func translating(_ point: CGPoint) -> CGPoint { return CGPoint(x: self.x + point.x, y: self.y + point.y) }
}

extension CGPoint
{
    public static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint { return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y) }
    public static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint { return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y) }

    public static func +(lhs: CGPoint, rhs: CGSize) -> CGPoint { return CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height) }
    public static func -(lhs: CGPoint, rhs: CGSize) -> CGPoint { return CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height) }

    public static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint { return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs) }
    public static func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint { return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs) }
}

extension CGPoint
{
    public static func +=(lhs: inout CGPoint, rhs: CGPoint) { lhs = lhs + rhs }
    public static func -=(lhs: inout CGPoint, rhs: CGPoint) { lhs = lhs - rhs }

    public static func +=(lhs: inout CGPoint, rhs: CGSize) { lhs = lhs + rhs }
    public static func -=(lhs: inout CGPoint, rhs: CGSize) { lhs = lhs - rhs }

    public static func *=(lhs: inout CGPoint, rhs: CGFloat) { lhs = lhs * rhs }
    public static func /=(lhs: inout CGPoint, rhs: CGFloat) { lhs = lhs / rhs }
}

extension CGPoint
{
    public static func >(lhs: CGPoint, rhs: CGPoint) -> Bool { return lhs.x > rhs.x && lhs.y > rhs.y }
    public static func <(lhs: CGPoint, rhs: CGPoint) -> Bool { return lhs.x < rhs.x && lhs.y < rhs.y }
    public static func >=(lhs: CGPoint, rhs: CGPoint) -> Bool { return lhs.x >= rhs.x && lhs.y >= rhs.y }
    public static func <=(lhs: CGPoint, rhs: CGPoint) -> Bool { return lhs.x <= rhs.x && lhs.y <= rhs.y }

    public static func >(lhs: CGPoint, rhs: CGSize) -> Bool { return lhs.x > rhs.width && lhs.y > rhs.height }
    public static func <(lhs: CGPoint, rhs: CGSize) -> Bool { return lhs.x < rhs.width && lhs.y < rhs.height }
    public static func >=(lhs: CGPoint, rhs: CGSize) -> Bool { return lhs.x >= rhs.width && lhs.y >= rhs.height }
    public static func <=(lhs: CGPoint, rhs: CGSize) -> Bool { return lhs.x <= rhs.width && lhs.y <= rhs.height }
}

public func floor(_ point: CGPoint) -> CGPoint { return CGPoint(x: floor(point.x), y: floor(point.y)) }
public func round(_ point: CGPoint) -> CGPoint { return CGPoint(x: round(point.x), y: round(point.y)) }
public func ceil(_ point: CGPoint) -> CGPoint { return CGPoint(x: ceil(point.x), y: ceil(point.y)) }

public func max(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint { return CGPoint(x: max(lhs.x, rhs.x), y: max(lhs.y, rhs.y)) }
public func min(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint { return CGPoint(x: min(lhs.x, rhs.x), y: min(lhs.y, rhs.y)) }

public func hypot(_ point: CGPoint) -> CGFloat { return hypot(point.x, point.y) }
public func hypot(_ lhs: CGPoint, _ rhs: CGPoint) -> CGFloat { return hypot(rhs - lhs) }