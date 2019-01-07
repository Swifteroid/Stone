import CoreGraphics

extension CGImage
{

    /// Returns current image resized to specified size and quality, the new image might have different characteristics.
    public func resize(to size: CGSize, interpolationQuality: CGInterpolationQuality? = nil) -> CGImage {

        // The context should be created based on the local system, not the current image, otherwise we might 
        // end up with `unsupported parameter combination` failures – they are common when loading screenshots 
        // stored directly by the Screen Capture app.

        let context: CGContext = CGContext(data: nil, width: Int(round(size.width)), height: Int(round(size.height)), bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)!
        context.interpolationQuality = interpolationQuality ?? CGInterpolationQuality.high
        context.draw(self, in: CGRect(origin: CGPoint.zero, size: size))
        return context.makeImage()!
    }

    /// Returns current image resized so that it fits into specified size.
    public func resize(fitting size: CGSize, interpolationQuality: CGInterpolationQuality? = nil) -> CGImage {
        return self.resize(to: self.size.fitting(aspect: size), interpolationQuality: interpolationQuality)
    }

    /// Returns current image resized so that it fills the specified size.
    public func resize(filling size: CGSize, interpolationQuality: CGInterpolationQuality? = nil) -> CGImage {
        return self.resize(to: self.size.filling(aspect: size), interpolationQuality: interpolationQuality)
    }
}

extension CGImage
{
    public var size: CGSize { return CGSize(width: self.width, height: self.height) }
}