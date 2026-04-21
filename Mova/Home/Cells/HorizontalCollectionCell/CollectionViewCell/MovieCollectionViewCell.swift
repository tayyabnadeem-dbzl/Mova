//
//  CollectionViewCell.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 17/04/2026.
//

import UIKit
import Foundation


final class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundCellImageView: UIImageView!
    @IBOutlet weak var ratingBackgroundView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        print("imageView:", backgroundCellImageView as Any)
        print("ratingView:", ratingBackgroundView as Any)
        print("ratingLabel:", ratingLabel as Any)
        setup()
    }
    
    func configure(with item: MovieItem) {
        backgroundCellImageView.image = UIImage(named: item.image)
        ratingLabel.text = item.rating
    }
}

private extension MovieCollectionViewCell {
    private func setup() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        ratingBackgroundView.layer.cornerRadius = 8
        ratingBackgroundView.clipsToBounds = true
        backgroundCellImageView.contentMode = .scaleAspectFill
        backgroundCellImageView.clipsToBounds = true
        ratingLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        ratingLabel.textColor = .white
        ratingBackgroundView.backgroundColor = .appRed
    }
}
