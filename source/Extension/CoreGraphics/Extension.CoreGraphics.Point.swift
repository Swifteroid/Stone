import CoreGraphics

extension CGPoint
{
    public static let infinite: CGPoint = CGPoint(x: CGFloat.infinity, y: CGFloat.infinity)
}

/// Translating.
extension CGPoint
{
    /// Translates the point along x axis by the given distance.
    public mutating func translate(x: CGFloat) { self.x += x }

    /// Translates the point along y axis by the given distance.
    public mutating func translate(y: CGFloat) { self.y += y }

    /// Translates the point along y and y axis by the given distance.
    public mutating func translate(x: CGFloat, y: CGFloat) { (self.x, self.y) = (self.x + x, self.y + y) }

    /// Translates the point along y and y axis by the given distance.
    public mutating func translate(_ distance: CGFloat) { self.translate(x: distance, y: distance) }

    /// Translates the point along y and y axis by the given distance.
    public mutating func translate(_ point: CGPoint) { self.translate(x: point.x, y: point.y) }

    /// Translates the point by the given distance in direction defined by the angle in radians.
    public mutating func translate(distance: CGFloat, angle: CGFloat) { self.translate(x: distance * cos(angle), y: distance * sin(angle)) }


    /// Returns the point translated along x axis by the given distance.
    public func translating(x: CGFloat) -> CGPoint { return CGPoint(x: self.x + x, y: self.y) }

    /// Returns the point translated along y axis by the given distance.
    public func translating(y: CGFloat) -> CGPoint { return CGPoint(x: self.x, y: self.y + y) }

    /// Returns the point translated along y and y axis by the given distance.
    public func translating(x: CGFloat, y: CGFloat) -> CGPoint { return CGPoint(x: self.x + x, y: self.y + y) }

    /// Returns the point translated along y and y axis by the given distance.
    public func translating(_ distance: CGFloat) -> CGPoint { return self.translating(x: distance, y: distance) }

    /// Returns the point translated along y and y axis by the given distance.
    public func translating(_ point: CGPoint) -> CGPoint { return self.translating(x: point.x, y: point.y) }

    /// Returns the point translated by the given distance in direction defined by the angle in radians.
    public func translating(distance: CGFloat, angle: CGFloat) -> CGPoint { return self.translating(x: distance * cos(angle), y: distance * sin(angle)) }
}

extension CGPoint
{
    public static prefix func -(rhs: CGPoint) -> CGPoint { return CGPoint(x: -rhs.x, y: -rhs.y) }

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