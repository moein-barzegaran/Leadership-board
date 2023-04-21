import UIKit

extension UIViewController {
    func add(_ child: UIViewController, to view: UIView? = nil) {
        addChild(child)
        (view ?? self.view).addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
