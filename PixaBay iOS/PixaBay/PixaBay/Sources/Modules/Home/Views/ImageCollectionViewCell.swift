import Foundation
import UIKit

struct ImageCellData {
    let imageUrl: String
    let title: String
    let subtitle: String
    let id: Int
}

class ImagesCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImagesCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        layer.cornerRadius = 15
        backgroundColor = UIColor(named: "AccentColor")
        titleLabel.backgroundColor = UIColor(named: "AccentColor")
        subtitleLabel.backgroundColor = UIColor(named: "AccentColor")
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -4),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
        ])
    }

    
    func configure(with data: ImageCellData) {
        if let imgUrl = URL(string: data.imageUrl) {
            imageView.downloaded(from: imgUrl, contentMode: .scaleAspectFill)
        } else {
            imageView.image = UIImage(named: "rectangle")
        }
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
    }
    
}
