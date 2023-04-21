import UIKit

class SegmentView: UIView {
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Friends", "Your location", "Global"])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
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
    
    private var selectedSegment: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
            switch sender.selectedSegmentIndex {
            case 0:
                print("Friends")
            case 1:
                print("Your location")
            case 2:
                print("Global")
            default:
                break
            }
        }
}
