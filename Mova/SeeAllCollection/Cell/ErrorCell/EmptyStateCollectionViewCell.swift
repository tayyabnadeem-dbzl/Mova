import UIKit

final class EmptyStateCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var messageLabel: UILabel!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK: - Setup
    private func setupUI() {
        messageLabel.textAlignment = .center
        messageLabel.textColor = .gray
        messageLabel.font = UIFont(name: "UrbanistRoman-Medium", size: 18)
        backgroundColor = .clear
    }
    
    //MARK: - Configure
    func configure(message: String) {
        messageLabel.text = message
    }
}
