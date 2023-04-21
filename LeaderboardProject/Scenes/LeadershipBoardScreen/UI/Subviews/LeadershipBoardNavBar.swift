import UIKit

class LeadershipBoardNavBar: UIView {
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Leaderboard"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
}

// MARK: Private methods

private extension LeadershipBoardNavBar {
    func setupViews() {
        addSubview(profileImageView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12)
        ])
        
        let profileImageViewHeightConstraint = profileImageView.heightAnchor.constraint(equalToConstant: 40)
        profileImageViewHeightConstraint.priority = .init(999)
        profileImageViewHeightConstraint.isActive = true
    }
}
