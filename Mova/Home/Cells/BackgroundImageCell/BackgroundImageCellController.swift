//
//  BackgroundImageCellController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 16/04/2026.
//

import UIKit

struct ButtonStyle {
    let title: String
    let imageName: String
    let backgroundColor: UIColor
    let textColor: UIColor
    let borderColor: UIColor?
}

protocol BackgroundImageCellControllerDelegate: AnyObject {
    func didTapPlay()
}

final class BackgroundImageCellController : UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var playButtonView: UIButton!
    @IBOutlet weak var myListButtonView: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //MARK: - Properties
    private var gradientLayer: CAGradientLayer?
    weak var delegate: BackgroundImageCellControllerDelegate?
    
    //MARK: - Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        playButtonView.round()
        myListButtonView.round()
        addGradient()
        setup()
        playButtonView.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
    }
    @objc private func didTapPlayButton() {
        delegate?.didTapPlay()
    }
    
    //MARK: - Configure
    func configure(with viewModel: BackgroundImageCellViewModel) {
        backgroundImageView.image = UIImage(named: viewModel.imageName)
        titleLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        playButtonView.setTitle(viewModel.playTitle, for: .normal)
        myListButtonView.setTitle(viewModel.listTitle, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = contentView.bounds
    }
}

//MARK: - Setup
private extension BackgroundImageCellController {
    
    func setup() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        titleLabel.font = UIFont(name: "UrbanistRoman-Bold", size: 34)
        titleLabel.text = "Dr. Strange"
        titleLabel.textColor = .white
        genreLabel.text = "something, something..."
        genreLabel.textColor = .white
        genreLabel.font = UIFont(name: "UrbanistRoman-Medium", size: 16)
        configureButton(playButtonView, style: ButtonStyle(
            title: "Play",
            imageName: "play-logo",
            backgroundColor: .appRed,
            textColor: .white,
            borderColor: nil
        ))
        configureButton(myListButtonView, style: ButtonStyle(
            title: "My List",
            imageName: "plus-logo",
            backgroundColor: .clear,
            textColor: .white,
            borderColor: .white
        ))
        
    }
    
    private func addGradient() {
        gradientLayer?.removeFromSuperlayer()
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.3).cgColor,
            UIColor.black.withAlphaComponent(0.6).cgColor
        ]
        gradient.locations = [0.0, 0.6, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        backgroundImageView.layer.addSublayer(gradient)
        gradientLayer = gradient
    }
}

private func configureButton(_ button: UIButton, style: ButtonStyle) {
    var config = UIButton.Configuration.filled()
    config.title = style.title
    config.image = UIImage(named: style.imageName)
    config.imagePlacement = .leading
    config.imagePadding = 4
    config.contentInsets = NSDirectionalEdgeInsets(
        top: 8,
        leading: 16,
        bottom: 8,
        trailing: 16
    )
    config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
        var outgoing = incoming
        outgoing.font = UIFont(name: "UrbanistRoman-Bold", size: 17)
        return outgoing
    }
    config.baseBackgroundColor = style.backgroundColor
    config.baseForegroundColor = style.textColor
    config.background.cornerRadius = 100
    if let border = style.borderColor {
        config.background.strokeWidth = 2
        config.background.strokeColor = border
    } else {
        config.background.strokeWidth = 0
    }
    button.configuration = config
    button.setNeedsUpdateConfiguration()
}

extension UIView {
    func round() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}
