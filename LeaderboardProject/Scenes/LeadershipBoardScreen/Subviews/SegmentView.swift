import UIKit

class SegmentView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = .zero
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Screen 1", "Screen 2", "Screen 3"])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
        segmentControl.selectedSegmentTintColor = .mainColor
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.segmentSelected], for: .selected)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.segmentDeselected], for: .normal)
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
        
        let heightConstraint = segmentControl.heightAnchor.constraint(equalToConstant: 45)
        heightConstraint.priority = .init(999)
        heightConstraint.isActive = true
    }
    
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
            case 0:
                print("Screen 1 selected")
            case 1:
                print("Screen 2 selected")
            case 2:
                print("Screen 3 selected")
            default:
                break
            }
        }
}
