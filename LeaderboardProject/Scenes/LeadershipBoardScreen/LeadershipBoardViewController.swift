import UIKit

class LeadershipBoardViewController: UIViewController {

    private lazy var navigationbar: LeadershipBoardNavBar = {
        let navbar = LeadershipBoardNavBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()
    
    private lazy var segmentView: SegmentView = {
        let segmentView = SegmentView()
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        return segmentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

// MARK: Private methods

private extension LeadershipBoardViewController {
    func setupViews() {
        addBackgroundGradientLayer()
        addNavigationView()
        addSegmentView()
    }
    
    func addNavigationView() {
        view.addSubview(navigationbar)
        
        NSLayoutConstraint.activate([
            navigationbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func addSegmentView() {
        view.addSubview(segmentView)
        
        NSLayoutConstraint.activate([
            segmentView.topAnchor.constraint(equalTo: navigationbar.bottomAnchor, constant: 12),
            segmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
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
