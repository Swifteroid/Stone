import AppKit

extension NSView
{
    public var visible: Bool {
        get {
            return !self.isHidden
        }
        set {
            self.isHidden = !newValue
        }
    }
}

// MARK: -

extension NSView
{
    public func getSubview(withIdentifier identifier: String) -> NSView? {
        for subview in self.subviews {
            if subview.identifier == identifier {
                return subview
            } else if subview.subviews.count > 0, let subview: NSView = subview.getSubview(withIdentifier: identifier) {
                return subview
            }
        }
        return nil
    }

    public func add(subview: NSView) {
        self.addSubview(subview)
    }

    public func add(subviews: [NSView]) {
        for view in subviews { self.addSubview(view) }
    }

    public func remove(subview: NSView) {
        if subview.superview == self { subview.removeFromSuperview() }
    }

    public func remove(subviews: [NSView]) {
        for view in subviews { self.remove(subview: view) }
    }
}

// MARK: constraint

extension NSView
{
    /*
    Returns active constraints of this view or between this view and the specified view. 
    */
    @nonobjc public func getConstraints(withView view: NSView? = nil) -> [NSLayoutConstraint] {

        // Current view may contain constraints of subview that are completely unrelated to it, hence we explicitly
        // check that each constraint relates to this particular view.

        var constraints: [NSLayoutConstraint] = []

        // Constraints are interesting guys – they sit inside the superview, so to access constraints for the current view
        // we must combine current view constraints and superview constraints. 

        for constraint in self.constraints + (self.superview?.constraints ?? []) {
            // @formatter:off
            if
            constraint.firstItem === self && (view == nil || constraint.secondItem === view) ||
            constraint.secondItem === self && (view == nil || constraint.firstItem === view) 
            {
                constraints.append(constraint)
            }
            // @formatter:on
        }

        return constraints
    }

    @nonobjc public func getConstraints(withViews views: [NSView]) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []

        for view in views {
            constraints.append(contentsOf: self.getConstraints(withView: view))
        }

        return constraints
    }

    @nonobjc public func getConstraint(withAttribute attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        return self.getConstraints(withAttribute: attribute).first
    }

    @nonobjc public func getConstraints(withAttribute attribute: NSLayoutAttribute) -> [NSLayoutConstraint] {
        return self.filterConstraints(self.getConstraints(), item: self, attribute: attribute)
    }

    @nonobjc public func getConstraint(withView view: NSView, withAttribute attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        return self.getConstraints(to: view, withAttribute: attribute).first
    }

    /*
    Returns constraints between the current view and the specified view, optional attribute parameter relates
    to the current view.
    */
    @nonobjc public func getConstraints(to view: NSView, withAttribute attribute: NSLayoutAttribute) -> [NSLayoutConstraint] {
        return self.filterConstraints(self.getConstraints(withView: view), item: view, attribute: attribute)
    }

    private func filterConstraints(_ constraints: [NSLayoutConstraint], item: AnyObject?, attribute: NSLayoutAttribute) -> [NSLayoutConstraint] {
        var product: [NSLayoutConstraint] = []

        for constraint in constraints {
            // @formatter:off
            if
            constraint.firstItem === item && constraint.firstAttribute == attribute ||
            constraint.secondItem === item && constraint.secondAttribute == attribute 
            {
                product.append(constraint)
            }
            // @formatter:on
        }

        return product
    }

    @discardableResult public func removeConstraints() -> Self {
        NSLayoutConstraint.deactivate(self.getConstraints())
        return self
    }

    @discardableResult public func removeConstraints(withView view: NSView) -> Self {
        NSLayoutConstraint.deactivate(self.getConstraints(withView: view))
        return self
    }

    @discardableResult public func removeConstraints(withViews views: [NSView]) -> Self {
        NSLayoutConstraint.deactivate(self.getConstraints(withViews: views))
        return self
    }
}