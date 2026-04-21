//
//  SeeAllCollectionViewController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 17/04/2026.
//

import Foundation
import UIKit

final class SeeAllCollectionViewController : UIViewController, UICollectionViewDelegate{
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    var viewModel: SeeAllCollectionViewModelType!
    var pageTitle: String?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleLeft(viewModel.title)
        setupNavbar()
        setupCollectionView()
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .medium),
        ]
        viewModel.onUpdate = { [weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.load()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyCollectionLayout()
    }
    
    @objc func didTapSearch() {
        print("Search tapped")
    }
}

private extension SeeAllCollectionViewController {
    func setupNavbar() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "search-dark")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private func applyCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = (collectionView.bounds.width - spacing) / 2
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: 248)
        layout.sectionInset = UIEdgeInsets(top: 8, left: .zero, bottom: 8, right: .zero)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private func setTitleLeft(_ text: String) {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = .label
        label.sizeToFit()
        let container = UIView()
        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        navigationItem.titleView = container
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(
             UINib(nibName: "SeeAllCollectionViewCell", bundle: nil),
             forCellWithReuseIdentifier: "SeeAllCollectionViewCell"
         )
    }
}

extension SeeAllCollectionViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SeeAllCollectionViewCell",
            for: indexPath
        ) as! SeeAllCollectionViewCell
        let character = viewModel.items[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}

