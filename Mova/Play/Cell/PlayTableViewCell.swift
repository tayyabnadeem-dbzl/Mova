//
//  PlayTableViewCell.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 23/04/2026.
//

import Foundation
import UIKit

final class PlayTableViewCell: HighlightableTableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var backgroundStatusLabelView: UIView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        highlightAnimation = .fade
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    //MARK: - Configure
    func configure(with viewModel: PlayTableCellViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        episodeLabel.text = viewModel.episode
        statusLabel.text = viewModel.status
        playImageView.loadImage(from: viewModel.imageURL)
    }
}

//MARK: - Setup
private extension PlayTableViewCell {
    func setupUI() {
        playImageView.contentMode = .scaleAspectFill
        playImageView.clipsToBounds = true
        playImageView.layer.cornerRadius = 12
        titleLabel.font = UIFont(name: "UrbanistRoman-SemiBold", size: 20)
        dateLabel.font = UIFont(name: "UrbanistRoman-Light", size: 13)
        dateLabel.textColor = .secondaryLabel
        episodeLabel.font = UIFont(name: "UrbanistRoman-Medium", size: 16)
        episodeLabel.textColor = .secondaryLabel
        statusLabel.font = UIFont(name: "UrbanistRoman-Medium", size: 12)
        statusLabel.textColor = .systemRed
        statusLabel.textAlignment = .center
        backgroundStatusLabelView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.12)
        backgroundStatusLabelView.layer.cornerRadius = 6
        backgroundStatusLabelView.clipsToBounds = true
    }
}

