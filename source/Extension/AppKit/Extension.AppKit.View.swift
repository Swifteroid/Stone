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
    public func subview(withIdentifier identifier: NSUserInterfaceItemIdentifier) -> NSView? {
        for subview in self.subviews {
            if subview.identifier == identifier {
                return subview
            } else if subview.subviews.count > 0, let subview: NSView = subview.subview(withIdentifier: identifier) {
                return subview
            }
        }
        return nil
    }

    public func add(subview: NSView) {
        self.addSubview(subview)
    }

    @nonobjc public func add(subview: NSView, positioned place: NSWindow.OrderingMode, relativeTo view: NSView? = nil) {
        self.addSubview(subview, positioned: place, relativeTo: view)
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

    /// Returns active constraints of this view or between this view and the specified view. 

    @nonobjc public func constraints(with view: NSView? = nil) -> [NSLayoutConstraint] {

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

    @nonobjc public func constraints(with views: [NSView]) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []

        for view in views {
            constraints += self.constraints(with: view)
        }

        return constraints
    }

    // MARK: -

    @nonobjc public func constraint(by attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        return self.constraints(by: attribute).first
    }

    @nonobjc public func constraints(by attribute: NSLayoutConstraint.Attribute) -> [NSLayoutConstraint] {
        return self.filter(constraints: self.constraints(), item: self, attribute: attribute)
    }

    // MARK: -

    @nonobjc public func constraint(with view: NSView, by attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        return self.constraints(with: view, by: attribute).first
    }

    /// Returns constraints between the current view and the specified view, optional attribute parameter relates
    /// to the current view.

    @nonobjc public func constraints(with view: NSView, by attribute: NSLayoutConstraint.Attribute) -> [NSLayoutConstraint] {
        return self.filter(constraints: self.constraints(with: view), item: view, attribute: attribute)
    }

    // MARK: -

    private func filter(constraints: [NSLayoutConstraint], item: AnyObject?, attribute: NSLayoutConstraint.Attribute) -> [NSLayoutConstraint] {
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

    // MARK: -

    @nonobjc @discardableResult public func removeConstraints() -> Self {
        NSLayoutConstraint.deactivate(self.constraints())
        return self
    }

    @nonobjc @discardableResult public func removeConstraints(with view: NSView) -> Self {
        NSLayoutConstraint.deactivate(self.constraints(with: view))
        return self
    }

    @nonobjc @discardableResult public func removeConstraints(with views: [NSView]) -> Self {
        NSLayoutConstraint.deactivate(self.constraints(with: views))
        return self
    }
}