import CoreGraphics

extension CGSize {
    public init(length: CGFloat) {
        self.init(width: length, height: length)
    }

    public init(with point: CGPoint) {
        self.init(width: point.x, height: point.y)
    }

    public static let infinite: CGSize = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
}

/// Scaling.
extension CGSize {
    /// Scales the size horizontally and vertically by the given amount.
    public mutating func scale(width ws: CGFloat, height hs: CGFloat) { (self.width, self.height) = (self.width * ws, self.height * hs) }

    /// Scales the size horizontally by the given amount.
    public mutating func scale(width ws: CGFloat) { self.width *= ws }

    /// Scales the size vertically by the given amount.
    public mutating func scale(height hs: CGFloat) { self.height *= hs }

    /// Scales the size horizontally and vertically by the given amount.
    public mutating func scale(_ scale: CGFloat) { self.scale(width: scale, height: scale) }

    /// Scales the size horizontally and vertically by the given amount.
    public mutating func scale(_ scale: CGPoint) { self.scale(width: scale.x, height: scale.y) }

    /// Scales the size horizontally and vertically by the given amount.
    public mutating func scale(_ scale: CGSize) { self.scale(width: scale.width, height: scale.height) }


    /// Returns the size scaled horizontally and vertically by the given amount.
    public func scaling(width ws: CGFloat, height hs: CGFloat) -> CGSize { return CGSize(width: self.width * ws, height: self.height * hs) }

    /// Returns the size scaled horizontally by the given amount.
    public func scaling(width ws: CGFloat) -> CGSize { return CGSize(width: self.width * ws, height: self.height) }

    /// Returns the size scaled vertically by the given amount.
    public func scaling(height hs: CGFloat) -> CGSize { return CGSize(width: self.width, height: self.height * hs) }

    /// Returns the size scaled horizontally and vertically by the given amount.
    public func scaling(_ scale: CGFloat) -> CGSize { return self.scaling(width: scale, height: scale) }

    /// Returns the size scaled horizontally and vertically by the given amount.
    public func scaling(_ scale: CGPoint) -> CGSize { return self.scaling(width: scale.x, height: scale.y) }

    /// Returns the size scaled horizontally and vertically by the given amount.
    public func scaling(_ scale: CGSize) -> CGSize { return self.scaling(width: scale.width, height: scale.height) }
}

extension CGSize {

    /// Returns new size adjusted to proportionally fill the specified size.
    public func filling(aspect size: CGSize) -> CGSize {
        var size: CGSize = size
        let widthRatio: CGFloat = size.width / self.width
        let heightRatio: CGFloat = size.height / self.height

        if widthRatio > heightRatio {
            size.height = widthRatio * self.height
        } else if heightRatio > widthRatio {
            size.width = heightRatio * self.width
        }

        return size
    }

    /// Returns new size adjusted to proportionally fit into the specified size.
    public func fitting(aspect size: CGSize) -> CGSize {
        var size: CGSize = size
        let widthRatio: CGFloat = size.width / self.width
        let heightRatio: CGFloat = size.height / self.height

        if widthRatio < heightRatio {
            size.height = widthRatio * self.height
        } else if heightRatio < widthRatio {
            size.width = heightRatio * self.width
        }

        return size
    }

    public func filling(width: CGFloat) -> CGSize { return self.filling(aspect: CGSize(width: width, height: 0)) }
    public func filling(height: CGFloat) -> CGSize { return self.filling(aspect: CGSize(width: 0, height: height)) }

    public func fitting(width: CGFloat) -> CGSize { return self.fitting(aspect: CGSize(width: width, height: CGFloat.infinity)) }
    public func fitting(height: CGFloat) -> CGSize { return self.fitting(aspect: CGSize(width: CGFloat.infinity, height: height)) }

    public func filling(aspect rect: CGRect) -> CGRect { return CGRect(origin: .zero, size: self.filling(aspect: rect.size)).centered(in: rect) }
    public func fitting(aspect rect: CGRect) -> CGRect { return CGRect(origin: .zero, size: self.fitting(aspect: rect.size)).centered(in: rect) }
}

extension CGSize {
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height) }
    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height) }

    public static func + (lhs: CGSize, rhs: CGPoint) -> CGSize { return CGSize(width: lhs.width + rhs.x, height: lhs.height + rhs.y) }
    public static func - (lhs: CGSize, rhs: CGPoint) -> CGSize { return CGSize(width: lhs.width - rhs.x, height: lhs.height - rhs.y) }

    public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize { return CGSize(width: lhs.width * rhs, height: lhs.height * rhs) }
    public static func / (lhs: CGSize, rhs: CGFloat) -> CGSize { return CGSize(width: lhs.width / rhs, height: lhs.height / rhs) }
}

extension CGSize {
    public static func > (lhs: CGSize, rhs: CGSize) -> Bool { return lhs.width > rhs.width && lhs.height > rhs.height }
    public static func < (lhs: CGSize, rhs: CGSize) -> Bool { return lhs.width < rhs.width && lhs.height < rhs.height }
    public static func >= (lhs: CGSize, rhs: CGSize) -> Bool { return lhs.width >= rhs.width && lhs.height >= rhs.height }
    public static func <= (lhs: CGSize, rhs: CGSize) -> Bool { return lhs.width <= rhs.width && lhs.height <= rhs.height }

    public static func > (lhs: CGSize, rhs: CGPoint) -> Bool { return lhs.width > rhs.x && lhs.height > rhs.y }
    public static func < (lhs: CGSize, rhs: CGPoint) -> Bool { return lhs.width < rhs.x && lhs.height < rhs.y }
    public static func >= (lhs: CGSize, rhs: CGPoint) -> Bool { return lhs.width >= rhs.x && lhs.height >= rhs.y }
    public static func <= (lhs: CGSize, rhs: CGPoint) -> Bool { return lhs.width <= rhs.x && lhs.height <= rhs.y }
}

extension CGSize {
    public static func += (lhs: inout CGSize, rhs: CGSize) { lhs = lhs + rhs }
    public static func -= (lhs: inout CGSize, rhs: CGSize) { lhs = lhs - rhs }

    public static func += (lhs: inout CGSize, rhs: CGPoint) { lhs = lhs + rhs }
    public static func -= (lhs: inout CGSize, rhs: CGPoint) { lhs = lhs - rhs }

    public static func *= (lhs: inout CGSize, rhs: CGFloat) { lhs = lhs * rhs }
    public static func /= (lhs: inout CGSize, rhs: CGFloat) { lhs = lhs / rhs }
}

public func floor(_ size: CGSize) -> CGSize { return CGSize(width: floor(size.width), height: floor(size.height)) }
public func round(_ size: CGSize) -> CGSize { return CGSize(width: round(size.width), height: round(size.height)) }
public func ceil(_ size: CGSize) -> CGSize { return CGSize(width: ceil(size.width), height: ceil(size.height)) }

public func max(_ lhs: CGSize, _ rhs: CGSize) -> CGSize { return CGSize(width: max(lhs.width, rhs.width), height: max(lhs.height, rhs.height)) }
public func min(_ lhs: CGSize, _ rhs: CGSize) -> CGSize { return CGSize(width: min(lhs.width, rhs.width), height: min(lhs.height, rhs.height)) }

public func hypot(_ size: CGSize) -> CGFloat { return hypot(size.width, size.height) }
