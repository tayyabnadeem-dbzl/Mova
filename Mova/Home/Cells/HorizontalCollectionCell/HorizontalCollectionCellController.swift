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
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupCollectionView()
        setup()
        seeAllButtonView.addTarget(
            self,
            action: #selector(seeAllButtonTapped),
            for: .touchUpInside
        )
    }
    
    //MARK: - Configure
    func configure(with viewModel: HorizontalCellViewModel) {
        collectionTitleLabel.text = viewModel.title
        items = viewModel.items
        collectionView.reloadData()
    }
}

//MARK: - Setup
private extension HorizontalCollectionCellController {
    func setup() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionTitleLabel.font = UIFont(name: "UrbanistRoman-SemiBold", size: 20)
        seeAllButtonView.tintColor = .appRed
        seeAllButtonView.titleLabel?.font = UIFont(name: "Urbanist-Regular", size: 20)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        collectionView.collectionViewLayout = layout
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewLayout()
        layout.collectionView?.contentInset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        collectionView.register(
            UINib(nibName: "MovieCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MovieCollectionViewCell"
        )
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

