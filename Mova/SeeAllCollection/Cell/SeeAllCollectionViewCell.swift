//
//  SeeAllCollectionViewCell.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 21/04/2026.
//

import Foundation
import UIKit
final class SeeAllCollectionViewCell: HighlightableCollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var nameBackgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundCellImageView: UIImageView!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    //MARK: - Configure
    func configure(with model: Character) {
        nameLabel.text = model.name
        backgroundCellImageView.loadImage(from: model.image)
    }
}

//MARK: - Setup
private extension SeeAllCollectionViewCell {

    func setup() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        backgroundCellImageView.contentMode = .scaleAspectFill
        backgroundCellImageView.clipsToBounds = true
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.10)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        backgroundCellImageView.addSubview(overlay)
        nameLabel.font = UIFont(name: "UrbanistRoman-Bold", size: 12)
        nameLabel.textColor = .white
        nameBackgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        nameBackgroundView.layer.cornerRadius = 8
        nameBackgroundView.clipsToBounds = true
        nameBackgroundView.layer.masksToBounds = true
    }
}
