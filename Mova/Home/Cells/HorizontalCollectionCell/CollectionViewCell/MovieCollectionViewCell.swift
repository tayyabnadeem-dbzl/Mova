//
//  CollectionViewCell.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 17/04/2026.
//

import UIKit
import Foundation


final class MovieCollectionViewCell: HighlightableCollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var backgroundCellImageView: UIImageView!
    @IBOutlet weak var ratingBackgroundView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //MARK: - Lifecyle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    //MARK: - Configure
    func configure(with item: MovieItem) {
        backgroundCellImageView.image = UIImage(named: item.image)
        ratingLabel.text = item.rating
    }
}

//MARK: - Setup
private extension MovieCollectionViewCell {
    private func setup() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        ratingBackgroundView.layer.cornerRadius = 8
        ratingBackgroundView.clipsToBounds = true
        backgroundCellImageView.contentMode = .scaleAspectFill
        backgroundCellImageView.clipsToBounds = true
        ratingLabel.font = UIFont(name: "UrbanistRoman-SemiBold", size: 12)
        ratingLabel.textColor = .white
        ratingBackgroundView.backgroundColor = .appRed
    }
}
