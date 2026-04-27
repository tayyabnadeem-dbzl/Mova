//
//  SeeAllCollectionViewController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 17/04/2026.
//

import Foundation
import UIKit

final class SeeAllCollectionViewController : UIViewController, UICollectionViewDelegate, UITextFieldDelegate{
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    var viewModel: SeeAllCollectionViewModelType!
    var pageTitle: String?
    private let searchTextField = UITextField()
    private var isSearching = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindView()
        viewModel.load()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyCollectionLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setupNavbar()
        updateNavigationUI()
    }

    @objc private func didTapSearch() {
        guard !isSearching else { return }
        isSearching = true
        setupSearchField()
        updateNavigationUI()
        searchTextField.becomeFirstResponder()
    }

    @objc private func exitSearch() {
        isSearching = false
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        viewModel.updateSearch(query: "")
        updateNavigationUI()
    }

    @objc private func searchChanged(_ textField: UITextField) {
        viewModel.updateSearch(query: textField.text ?? "")
    }
}

//MARK: - Setup 
private extension SeeAllCollectionViewController {
    func setupNavbar() {
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "UrbanistRoman-Medium", size: 20) ?? .systemFont(ofSize: 20),
        ]
        view.backgroundColor = .white
    }

    func applyCollectionLayout() {
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
    
    func setTitleLeft(_ text: String) {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "UrbanistRoman-Medium", size: 22)
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
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(
             UINib(nibName: "SeeAllCollectionViewCell", bundle: nil),
             forCellWithReuseIdentifier: "SeeAllCollectionViewCell"
         )
        collectionView.register(
             UINib(nibName: "EmptyStateCollectionViewCell", bundle: nil),
             forCellWithReuseIdentifier: "EmptyStateCollectionViewCell"
         )
    }
    
    func setupSearchField() {
        searchTextField.placeholder = "  Search characters"
        searchTextField.backgroundColor = UIColor.systemGray6
        searchTextField.layer.cornerRadius = 10
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.returnKeyType = .done
        searchTextField.delegate = self
        searchTextField.frame = CGRect(x: 0, y: 0, width: 250, height: 36)
        searchTextField.backgroundColor = .textfied
        searchTextField.addTarget(self, action: #selector(searchChanged(_:)), for: .editingChanged)
    }
    
    func setupSearchButton() {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(named: "search-dark")?.withRenderingMode(.alwaysOriginal),
            for: .normal
        )
        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func updateNavigationUI() {
        if isSearching {
            navigationItem.titleView = searchTextField
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self,
                action: #selector(exitSearch)
            )
        } else {
            setTitleLeft(viewModel.title)
            setupSearchButton()
        }
    }
}

extension SeeAllCollectionViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.isEmpty ? 1 : viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.items.isEmpty {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "EmptyStateCollectionViewCell",
                for: indexPath
            ) as! EmptyStateCollectionViewCell
            let message = isSearching ? "No results found " : "No data exists"
            cell.configure(message: message)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SeeAllCollectionViewCell",
            for: indexPath
        ) as! SeeAllCollectionViewCell
        let character = viewModel.items[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}

//MARK: - Binding
private extension SeeAllCollectionViewController {
    func bindView(){
        viewModel.onUpdate = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
extension SeeAllCollectionViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SeeAllCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.items.isEmpty {
            return CGSize(width: collectionView.bounds.width, height: 400)
        }
        let spacing: CGFloat = 8
        let width = (collectionView.bounds.width - spacing) / 2
        return CGSize(width: width, height: 248)
    }
}
