import AppKit

public protocol StoryboardController
{
    associatedtype StoryboardController

    static func construct(from storyboard: NSStoryboard) -> StoryboardController
}

extension StoryboardController
{
    public static func construct(from storyboard: NSStoryboard) -> StoryboardController {
        return storyboard.instantiateController(withIdentifier: String(describing: self)) as! StoryboardController
    }
}