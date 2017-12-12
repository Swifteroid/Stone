import CoreGraphics

extension CGRect
{

    /// Constructs new rectangle by finding the difference between two points.

    public init(point point1: CGPoint, point point2: CGPoint) {
        self.init(x: min(point1.x, point2.x), y: min(point1.y, point2.y), width: abs(point2.x - point1.x), height: abs(point2.y - point1.y))
    }
}

/// Anchor points, setting these resizes the rectangle in the given direction, changing center points resizes
/// rectangle in both ways on axis it sits on.

extension CGRect
{
    public var topLeft: CGPoint {
        get { return CGPoint(x: self.minX, y: self.minY) }
        mutating set {
            self.size.width -= newValue.x - self.minX
            self.size.height -= newValue.y - self.minY
            self.origin = newValue
        }
    }

    public var topRight: CGPoint {
        get { return CGPoint(x: self.maxX, y: self.minY) }
        mutating set {
            self.size.width += newValue.x - self.maxX
            self.size.height -= newValue.y - self.minY
            self.origin = newValue.translating(x: -self.width)
        }
    }

    public var bottomLeft: CGPoint {
        get { return CGPoint(x: self.minX, y: self.maxY) }
        mutating set {
            self.size.width -= newValue.x - self.minX
            self.size.height += newValue.y - self.maxY
            self.origin = newValue.translating(y: -self.height)
        }
    }

    public var bottomRight: CGPoint {
        get { return CGPoint(x: self.maxX, y: self.maxY) }
        mutating set {
            self.size.width += newValue.x - self.maxX
            self.size.height += newValue.y - self.maxY
            self.origin = newValue.translating(x: -self.width, y: -self.height)
        }
    }

    public var centerLeft: CGPoint {
        get { return CGPoint(x: self.minX, y: self.midY) }
        mutating set {
            let diff = newValue.y - self.midY
            self.size.width -= newValue.x - self.minX
            self.size.height -= diff * 2
            self.origin = newValue.translating(y: -self.height / 2 - diff)
        }
    }

    public var centerRight: CGPoint {
        get { return CGPoint(x: self.maxX, y: self.midY) }
        mutating set {
            let diff = newValue.y - self.midY
            self.size.width += newValue.x - self.maxX
            self.size.height -= diff * 2
            self.origin = newValue.translating(x: -self.width, y: -self.height / 2 - diff)
        }
    }

    public var centerTop: CGPoint {
        get { return CGPoint(x: self.midX, y: self.minY) }
        mutating set {
            let diff = newValue.x - self.midX
            self.size.width -= diff * 2
            self.size.height -= newValue.y - self.minY
            self.origin = newValue.translating(x: -self.width / 2 - diff)
        }
    }

    public var centerBottom: CGPoint {
        get { return CGPoint(x: self.midX, y: self.maxY) }
        mutating set {
            let diff = newValue.x - self.midX
            self.size.width -= diff * 2
            self.size.height += newValue.y - self.maxY
            self.origin = newValue.translating(x: -self.width / 2 - diff, y: -self.height)
        }
    }
}

/// Alignment and centering.

extension CGRect
{
    public func aligned(left rectangle: CGRect) -> CGRect { return CGRect(origin: CGPoint(x: rectangle.minX, y: self.origin.y), size: self.size) }
    public func aligned(right rectangle: CGRect) -> CGRect { return CGRect(origin: CGPoint(x: rectangle.maxX - self.width, y: self.origin.y), size: self.size) }
    public func aligned(top rectangle: CGRect) -> CGRect { return CGRect(origin: CGPoint(x: self.origin.x, y: rectangle.maxY - self.height), size: self.size) }
    public func aligned(bottom rectangle: CGRect) -> CGRect { return CGRect(origin: CGPoint(x: self.origin.x, y: rectangle.minY), size: self.size) }
    public func aligned(center rectangle: CGRect) -> CGRect { return self.centered(in: rectangle) }

    public var center: CGPoint {
        get { return CGPoint(x: self.midX, y: self.midY) }
        mutating set { self.origin = newValue.translating(x: -self.width / 2, y: -self.height / 2) }
    }

    public func centered(at point: CGPoint) -> CGRect { return CGRect(origin: CGPoint(x: point.x - self.width / 2, y: point.y - self.height / 2), size: self.size) }
    public func centered(in rectangle: CGRect) -> CGRect { return CGRect(origin: CGPoint(x: rectangle.origin.x + (rectangle.width - self.width) / 2, y: rectangle.origin.y + (rectangle.height - self.height) / 2), size: self.size) }
    public func centered(horizontally rectangle: CGRect) -> CGRect { return CGRect(origin: CGPoint(x: rectangle.origin.x + (rectangle.width - self.width) / 2, y: self.origin.y), size: self.size) }
    public func centered(vertically rectangle: CGRect) -> CGRect { return CGRect(origin: CGPoint(x: self.origin.x, y: rectangle.origin.y + (rectangle.height - self.height) / 2), size: self.size) }
}

/// Translating.

extension CGRect
{
    public mutating func translate(x: CGFloat, y: CGFloat) { self.origin.translate(x: x, y: y) }
    public mutating func translate(x: CGFloat) { self.origin.translate(x: x) }
    public mutating func translate(y: CGFloat) { self.origin.translate(y: y) }

    public func translating(x: CGFloat, y: CGFloat) -> CGRect { return CGRect(origin: self.origin.translating(x: x, y: y), size: self.size) }
    public func translating(x: CGFloat) -> CGRect { return CGRect(origin: self.origin.translating(x: x), size: self.size) }
    public func translating(y: CGFloat) -> CGRect { return CGRect(origin: self.origin.translating(y: y), size: self.size) }
}

extension CGRect
{

    /// Insets rectangle by a given distance.

    public func inset(by distance: CGFloat) -> CGRect {
        return self.insetBy(dx: distance, dy: distance)
    }

    /// Checks if current rectangle is within (bound by) the specified one and returns current rectangle
    /// with origin adjusted to bounding rectangle, i.e., in bounding rectangle coordinate space.

    public func bound(by bounds: CGRect) -> CGRect? {
        return bounds.intersection(self) == CGRect.null ? nil : self - bounds.origin
    }
}

extension CGRect
{
    /// Increases rectangle size by given size width and height.
    public static func +(lhs: CGRect, rhs: CGSize) -> CGRect { return CGRect(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width + rhs.width, height: lhs.height + rhs.height) }

    /// Decreases rectangle size by given size width and height.
    public static func -(lhs: CGRect, rhs: CGSize) -> CGRect { return CGRect(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width - rhs.width, height: lhs.height - rhs.height) }

    /// Increases rectangle origin x and y by given point x and y.
    public static func +(lhs: CGRect, rhs: CGPoint) -> CGRect { return CGRect(x: lhs.origin.x + rhs.x, y: lhs.origin.y + rhs.y, width: lhs.width, height: lhs.height) }

    /// Decreases rectangle origin x and y by given point x and y.
    public static func -(lhs: CGRect, rhs: CGPoint) -> CGRect { return CGRect(x: lhs.origin.x - rhs.x, y: lhs.origin.y - rhs.y, width: lhs.width, height: lhs.height) }

    /// Multiplies rectangle origin x and y and size width and height by given amount.
    public static func *(lhs: CGRect, rhs: CGFloat) -> CGRect { return CGRect(x: lhs.origin.x * rhs, y: lhs.origin.y * rhs, width: lhs.width * rhs, height: lhs.height * rhs) }

    /// Divides rectangle origin x and y and size width and height by given amount.
    public static func /(lhs: CGRect, rhs: CGFloat) -> CGRect { return CGRect(x: lhs.origin.x / rhs, y: lhs.origin.y / rhs, width: lhs.width / rhs, height: lhs.height / rhs) }
}

extension CGRect
{
    public static func +=(lhs: inout CGRect, rhs: CGSize) { lhs = lhs + rhs }
    public static func -=(lhs: inout CGRect, rhs: CGSize) { lhs = lhs - rhs }

    public static func +=(lhs: inout CGRect, rhs: CGPoint) { lhs = lhs + rhs }
    public static func -=(lhs: inout CGRect, rhs: CGPoint) { lhs = lhs - rhs }

    public static func *=(lhs: inout CGRect, rhs: CGFloat) { lhs = lhs * rhs }
    public static func /=(lhs: inout CGRect, rhs: CGFloat) { lhs = lhs / rhs }
}

/// Rounds rectangle origin x and y and size width and height.
public func round(_ rectangle: CGRect) -> CGRect { return CGRect(origin: round(rectangle.origin), size: round(rectangle.size)) }