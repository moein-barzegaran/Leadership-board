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
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addBackgroundGradientToContentView()
    }
}

// MARK: Private methods

private extension LeadershipBoardViewController {
    func setupViews() {
        addBackgroundGradientToSuperView()
        addNavigationView()
        addContentView()
    }
    
    func addNavigationView() {
        view.addSubview(navigationbar)
        
        NSLayoutConstraint.activate([
            navigationbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func addContentView() {
        view.addSubview(contentView)
        contentView.addSubview(segmentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: navigationbar.bottomAnchor, constant: 12),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            segmentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            segmentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            segmentView.trailingAnchor.constraint(equalTo: contentView .trailingAnchor, constant: -8),
            segmentView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func addBackgroundGradientToSuperView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.gradientTop,
                                UIColor.gradientCenter,
                                UIColor.gradientBottom].map { $0.cgColor }
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }
    
    func addBackgroundGradientToContentView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.gradientTop,
                                UIColor.gradientCenter,
                                UIColor.gradientBottom].map { $0.cgColor }
        gradientLayer.frame = contentView.bounds
        gradientLayer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        gradientLayer.cornerRadius = 10
        gradientLayer.masksToBounds = true
        contentView.layer.insertSublayer(gradientLayer, at: 0)
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 4
    }
}
