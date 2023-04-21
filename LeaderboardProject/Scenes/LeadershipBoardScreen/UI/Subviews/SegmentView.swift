import UIKit

protocol SegmentViewProtocol: AnyObject {
    func segmentValueChanged(_ index: Int)
}

class SegmentView: UIView {
    
    
    // MARK: Private properties
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: segmentTitles)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = selectedIndex
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
        segmentControl.selectedSegmentTintColor = .mainColor
        segmentControl.backgroundColor = .clear
        segmentControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.segmentSelected,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
            ],
            for: .selected
        )
        segmentControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.segmentDeselected,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            ],
            for: .normal
        )
        return segmentControl
    }()
    
    private let selectedIndex: Int
    private let segmentTitles: [String]

    // MARK: Public properties
    
    weak var delegate: SegmentViewProtocol?
    
    init(segments: [String], selectedIndex: Int, delegate: SegmentViewProtocol? = nil) {
        self.segmentTitles = segments
        self.selectedIndex = selectedIndex
        
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension SegmentView {
    func setupViews() {
        addSubview(segmentControl)
        NSLayoutConstraint.activate([
            segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            segmentControl.topAnchor.constraint(equalTo: topAnchor),
            segmentControl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.segmentValueChanged(sender.selectedSegmentIndex)
    }
}
