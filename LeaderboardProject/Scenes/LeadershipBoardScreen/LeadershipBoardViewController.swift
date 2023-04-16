import UIKit

class LeadershipBoardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackgroundGradientLayer()
    }
}

// MARK: Private methods

private extension LeadershipBoardViewController {
    func addBackgroundGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.gradientTop,
                                UIColor.gradientCenter,
                                UIColor.gradientBottom].map { $0.cgColor }
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
