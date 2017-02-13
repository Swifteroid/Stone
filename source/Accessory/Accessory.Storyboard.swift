import AppKit.NSStoryboard

public protocol StoryboardController
{
}

extension StoryboardController
{
    public static func construct(from storyboard: NSStoryboard) -> Self {
        return storyboard.instantiateController(withIdentifier: String(describing: self)) as! Self
    }
}