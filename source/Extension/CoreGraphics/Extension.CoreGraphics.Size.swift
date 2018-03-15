import CoreGraphics

extension CGSize
{
    public init(length: CGFloat) {
        self.init(width: length, height: length)
    }

    public init(with point: CGPoint) {
        self.init(width: point.x, height: point.y)
    }
}

extension CGSize
{

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

    public func filling(aspect rect: CGRect) -> CGRect { return CGRect(origin: .zero, size: self.filling(aspect: rect.size)).centered(in: rect) }
    public func fitting(aspect rect: CGRect) -> CGRect { return CGRect(origin: .zero, size: self.fitting(aspect: rect.size)).centered(in: rect) }
}

extension CGSize
{
    public static func +(lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height) }
    public static func -(lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height) }

    public static func +(lhs: CGSize, rhs: CGPoint) -> CGSize { return CGSize(width: lhs.width + rhs.x, height: lhs.height + rhs.y) }
    public static func -(lhs: CGSize, rhs: CGPoint) -> CGSize { return CGSize(width: lhs.width - rhs.x, height: lhs.height - rhs.y) }

    public static func *(lhs: CGSize, rhs: CGFloat) -> CGSize { return CGSize(width: lhs.width * rhs, height: lhs.height * rhs) }
    public static func /(lhs: CGSize, rhs: CGFloat) -> CGSize { return CGSize(width: lhs.width / rhs, height: lhs.height / rhs) }
}

extension CGSize
{
    public static func >(lhs: CGSize, rhs: CGSize) -> Bool { return lhs.width > rhs.width && lhs.height > rhs.height }
    public static func <(lhs: CGSize, rhs: CGSize) -> Bool { return lhs.width < rhs.width && lhs.height < rhs.height }
    public static func >=(lhs: CGSize, rhs: CGSize) -> Bool { return lhs.width >= rhs.width && lhs.height >= rhs.height }
    public static func <=(lhs: CGSize, rhs: CGSize) -> Bool { return lhs.width <= rhs.width && lhs.height <= rhs.height }

    public static func >(lhs: CGSize, rhs: CGPoint) -> Bool { return lhs.width > rhs.x && lhs.height > rhs.y }
    public static func <(lhs: CGSize, rhs: CGPoint) -> Bool { return lhs.width < rhs.x && lhs.height < rhs.y }
    public static func >=(lhs: CGSize, rhs: CGPoint) -> Bool { return lhs.width >= rhs.x && lhs.height >= rhs.y }
    public static func <=(lhs: CGSize, rhs: CGPoint) -> Bool { return lhs.width <= rhs.x && lhs.height <= rhs.y }
}

extension CGSize
{
    public static func +=(lhs: inout CGSize, rhs: CGSize) { lhs = lhs + rhs }
    public static func -=(lhs: inout CGSize, rhs: CGSize) { lhs = lhs - rhs }

    public static func +=(lhs: inout CGSize, rhs: CGPoint) { lhs = lhs + rhs }
    public static func -=(lhs: inout CGSize, rhs: CGPoint) { lhs = lhs - rhs }

    public static func *=(lhs: inout CGSize, rhs: CGFloat) { lhs = lhs * rhs }
    public static func /=(lhs: inout CGSize, rhs: CGFloat) { lhs = lhs / rhs }
}

public func floor(_ size: CGSize) -> CGSize { return CGSize(width: floor(size.width), height: floor(size.height)) }
public func round(_ size: CGSize) -> CGSize { return CGSize(width: round(size.width), height: round(size.height)) }
public func ceil(_ size: CGSize) -> CGSize { return CGSize(width: ceil(size.width), height: ceil(size.height)) }

public func max(_ lhs: CGSize, _ rhs: CGSize) -> CGSize { return CGSize(width: max(lhs.width, rhs.width), height: max(lhs.height, rhs.height)) }
public func min(_ lhs: CGSize, _ rhs: CGSize) -> CGSize { return CGSize(width: min(lhs.width, rhs.width), height: min(lhs.height, rhs.height)) }

public func hypot(_ size: CGSize) -> CGFloat { return hypot(size.width, size.height) }