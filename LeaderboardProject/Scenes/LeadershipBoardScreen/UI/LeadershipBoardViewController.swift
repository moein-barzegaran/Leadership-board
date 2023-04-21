import UIKit

class LeadershipBoardViewController: UIViewController {

    private lazy var navigationbar: LeadershipBoardNavBar = {
        let navbar = LeadershipBoardNavBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()
    
    private lazy var segmentView: SegmentView = {
        let segmentView = SegmentView(segments: viewModel.segmentTitles, selectedIndex: viewModel.activeSegmentIndex)
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.delegate = self
        return segmentView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var contentViewController: UIViewController?
    private let viewModel: LeadershipBoardViewModel
    
    init(viewModel: LeadershipBoardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        // Initialize the ViewModel states
        viewModel.viewDidLoad()
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
    
    func setContentViewController(_ controller: UIViewController) {
        if let previousController = contentViewController {
            previousController.remove()
            contentViewController = nil
        }
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        add(controller, to: contentView)
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 8),
            controller.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        controller.view.layer.cornerRadius = 10
        controller.view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        contentViewController = controller
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

// MARK: - LeadershipBoardViewModelProtocol

extension LeadershipBoardViewController: LeadershipBoardViewModelProtocol {
    func setNewSegmentController(_ controller: UIViewController) {
        setContentViewController(controller)
    }
}

// MARK: - SegmentViewProtocol

extension LeadershipBoardViewController: SegmentViewProtocol {
    func segmentValueChanged(_ index: Int) {
        viewModel.setNewSegment(index)
    }
}
