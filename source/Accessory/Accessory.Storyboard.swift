import AppKit

public protocol StoryboardController
{
}

extension StoryboardController
{
    public static func construct(from storyboard: NSStoryboard, load: Bool = true) -> Self {
        let controller: Self = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(String(describing: self))) as! Self

        // In most cases it doesn't matter whether the view is loaded or not, but in rare cases it needs to be loaded 
        // immediately. Since controller gets used / view gets loaded shortly after instantiation, we can load it here
        // by default, as it won't have any significant impact.

        if load, let controller: NSViewController = controller as? NSViewController, !controller.isViewLoaded {
            controller.loadView()
        }

        return controller
    }
}