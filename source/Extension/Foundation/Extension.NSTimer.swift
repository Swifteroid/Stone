import Foundation

extension Timer
{

    /// Creates and schedules a `Timer` instance.
    ///
    /// - parameters delay: The delay (in seconds) before execution.
    /// - parameters interval: The interval (in seconds) between each execution of `handler`. Note that
    ///   individual calls may be delayed; subsequent calls to `handler` will be based on the time the 
    ///   timer was created.
    /// - parameters handler: Block to execute at each `interval`.
    ///
    /// - returns: Scheduled `Timer` instance.

    @discardableResult public static func schedule(delay: TimeInterval, interval: TimeInterval, handler: @escaping (Timer) -> ()) -> Timer {
        let timer: Timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, delay + CFAbsoluteTimeGetCurrent(), interval, 0, 0, { handler($0!) })
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }

    @discardableResult public static func schedule(delay: TimeInterval, interval: TimeInterval, handler: @escaping () -> ()) -> Timer {
        return self.schedule(delay: delay, interval: interval, handler: { _ in handler() })
    }
}

extension Timer
{
    @discardableResult public static func schedule(delay: TimeInterval, handler: @escaping (Timer) -> ()) -> Timer {
        return self.schedule(delay: delay, interval: 0, handler: handler)
    }

    @discardableResult public static func schedule(delay: TimeInterval, handler: @escaping () -> ()) -> Timer {
        return self.schedule(delay: delay, interval: 0, handler: handler)
    }
}

extension Timer
{
    @discardableResult public static func schedule(interval: TimeInterval, handler: @escaping (Timer) -> ()) -> Timer {
        return self.schedule(delay: interval, interval: interval, handler: handler)
    }

    @discardableResult public static func schedule(interval: TimeInterval, handler: @escaping () -> ()) -> Timer {
        return self.schedule(delay: interval, interval: interval, handler: handler)
    }
}