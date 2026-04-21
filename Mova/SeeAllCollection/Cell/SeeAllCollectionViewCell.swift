//
//  SeeAllCollectionViewCell.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 21/04/2026.
//

import Foundation
import UIKit
final class SeeAllCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var backgroundCellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func configure(with model: Character) {
        ratingLabel.text = model.name
        backgroundCellImageView.loadImage(from: model.image)
    }
}

private extension SeeAllCollectionViewCell {

    func setup() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        backgroundCellImageView.contentMode = .scaleAspectFill
        backgroundCellImageView.clipsToBounds = true
        ratingLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        ratingLabel.textColor = .white
    }
}
