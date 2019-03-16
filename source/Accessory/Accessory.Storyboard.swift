import AppKit

/// Controller that belongs to a specific storyboard and can be constructed out of it.
public protocol StoryboardController
{
}

extension StoryboardController
{

    /// Constructs controller from the specified storyboard and optionally loads the view. In most cases it doesn't matter whether the view is loaded
    /// or not, but in rare cases it needs to be loaded immediately. Since controller gets used / view gets loaded shortly after instantiation, we can
    /// load it here  by default, as it won't have any significant impact.
    public static func construct(from storyboard: NSStoryboard, load: Bool = true) -> Self {
        let controller: Self = storyboard.instantiateController(withIdentifier: String(describing: self)) as! Self

        if load, let controller: NSViewController = controller as? NSViewController, !controller.isViewLoaded {
            controller.loadView()
        }

        return controller
    }
}
