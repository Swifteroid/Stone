import Foundation

extension Timer
{
    private typealias Block = () -> ()
    private typealias TimerHandler = (Timer) -> ()
    private typealias TimerHandlerOptional = (Timer?) -> ()

    /*
    Creates and schedules a one-time `NSTimer` instance.

    - Parameters:
        - delay: The delay before execution.
        - handler: A closure to execute after `delay`.

    - Returns: The newly-created `NSTimer` instance.
    */
    @discardableResult public static func schedule(delay: TimeInterval, handler: Any) -> Timer {
        var timerHandler: TimerHandlerOptional!

        if let handler: Block = handler as? Block {
            timerHandler = { (timer: Timer?) in handler() }
        } else if let handler: TimerHandler = handler as? TimerHandler {
            timerHandler = { (timer: Timer?) in handler(timer!) }
        } else if let handler: TimerHandlerOptional = handler as? TimerHandlerOptional {
            timerHandler = handler
        } else {
            preconditionFailure()
        }

        if #available(OSX 10.12, *) {
            return self.scheduledTimer(withTimeInterval: delay, repeats: false, block: timerHandler)
        } else {
            let fireDate: TimeInterval = delay + CFAbsoluteTimeGetCurrent()
            let timer: Timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, timerHandler)
            CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
            return timer
        }
    }

    /*
    Creates and schedules a repeating `NSTimer` instance.

    - Parameters:
        - interval: The interval (in seconds) between each execution of
          `handler`. Note that individual calls may be delayed; subsequent calls
          to `handler` will be based on the time the timer was created.
        - handler: A closure to execute at each `interval`.

    - Returns: The newly-created `NSTimer` instance.
    */
    @discardableResult public static func schedule(interval: TimeInterval, handler: Any) -> Timer {
        var timerHandler: TimerHandlerOptional!

        if let handler: Block = handler as? Block {
            timerHandler = { (timer: Timer?) in handler() }
        } else if let handler: TimerHandler = handler as? TimerHandler {
            timerHandler = { (timer: Timer?) in handler(timer!) }
        } else if let handler: TimerHandlerOptional = handler as? TimerHandlerOptional {
            timerHandler = handler
        } else {
            preconditionFailure()
        }

        if #available(OSX 10.12, *) {
            return self.scheduledTimer(withTimeInterval: interval, repeats: true, block: timerHandler)
        } else {
            let fireDate: TimeInterval = interval + CFAbsoluteTimeGetCurrent()
            let timer: Timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, timerHandler)
            CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
            return timer
        }
    }
}