//
//  HorizontalCollectionCellController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 16/04/2026.
//

import Foundation
import UIKit

protocol HorizontalCollectionCellControllerDelegate: AnyObject {
    func didTapSeeAll(title: String, items: [MovieItem])
}

final class HorizontalCollectionCellController : UITableViewCell, UICollectionViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionTitleLabel: UILabel!
    @IBOutlet weak var seeAllButtonView: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var items: [MovieItem] = []
    weak var delegate: HorizontalCollectionCellControllerDelegate?
    var title : String = ""
    
    //MARK: - Constants
    enum Constants {
        static let seeAllTitile = "Top 10 Movies This Week"
    }

    @objc func seeAllButtonTapped() {
        delegate?.didTapSeeAll(title: title, items: items)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewLayout()
        layout.collectionView?.contentInset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        collectionView.register(
            UINib(nibName: "MovieCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MovieCollectionViewCell"
        )
        seeAllButtonView.addTarget(
            self,
            action: #selector(seeAllButtonTapped),
            for: .touchUpInside
        )
        setup()
    }
    
    func configure(with viewModel: HorizontalCellViewModel) {
        collectionTitleLabel.text = viewModel.title
        items = viewModel.items
        collectionView.reloadData()
    }
}

private extension HorizontalCollectionCellController {

    func setup() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionTitleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        seeAllButtonView.tintColor = .appRed
        seeAllButtonView.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        collectionView.collectionViewLayout = layout
    }
}

extension HorizontalCollectionCellController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MovieCollectionViewCell",
            for: indexPath
        ) as! MovieCollectionViewCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
}

