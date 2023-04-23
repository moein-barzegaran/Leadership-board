import UIKit

class UserCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private var currentImageURL: URL?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            usernameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        let avatarTopConstraint = avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        avatarTopConstraint.priority = .init(999)
        avatarTopConstraint.isActive = true
    }
    
    // MARK: - Public methods
    
    func configure(with user: User?) {
        guard let user else { return }
        usernameLabel.text = user.firstName + " " + user.lastName
        
        // Clear current avatar image
        avatarImageView.image = nil
        
        // Load new avatar image
        if let imageURL = URL(string: user.avatar) {
            currentImageURL = imageURL
            ImageCache.shared.load(from: imageURL) { [weak self] result in
                guard let self = self else { return }
                
                if let loadedImage = try? result.get() {
                    if self.currentImageURL == imageURL {
                        DispatchQueue.main.async {
                            self.avatarImageView.image = loadedImage
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        currentImageURL = nil
    }
}
