//
//  PlayViewController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 23/04/2026.
//

import Foundation
import UIKit

final class PlayViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: PlayViewModelType!
    var pageTitle: String?
    private var dataSource: UITableViewDiffableDataSource<Int, Int>!
    private let searchTextField = UITextField()
    private var isSearching = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDataSource()
        updateNavigationUI()
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.applySnapshot(items: self.viewModel.items)
        }
        viewModel.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
private extension PlayViewController {

    func setup() {
        setupTableView()
        setupNavbar()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(
            UINib(nibName: "PlayTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PlayTableViewCell"
        )
        tableView.register(
            UINib(nibName: "EmptyStateCell", bundle: nil),
            forCellReuseIdentifier: "EmptyStateCell"
        )
    }

    func setupNavbar() {
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "UrbanistRoman-Medium", size: 20) ?? .systemFont(ofSize: 20),
        ]
        view.backgroundColor = .white
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
    
    func setupSearchButton() {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(named: "search-dark")?.withRenderingMode(.alwaysOriginal),
            for: .normal
        )
        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func setupSearchField() {
        searchTextField.placeholder = "  Search Movies"
        searchTextField.backgroundColor = .textfied
        searchTextField.layer.cornerRadius = 10
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.returnKeyType = .done
        searchTextField.delegate = self
        searchTextField.frame = CGRect(x: 0, y: 0, width: 250, height: 36)
        searchTextField.addTarget(self, action: #selector(searchChanged(_:)), for: .editingChanged)
    }

    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, Int>(
            tableView: tableView
        ) { [weak self] tableView, indexPath, itemId in
            guard let self = self else { return UITableViewCell() }
            if itemId == -1 {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "EmptyStateCell",
                    for: indexPath
                ) as? EmptyStateCell else {
                    return UITableViewCell()
                }
                let message = isSearching ? "No results found" : "No data exists"
                cell.configure(message: message)
                return cell
            }
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "PlayTableViewCell",
                for: indexPath
            ) as? PlayTableViewCell else {
                return UITableViewCell()
            }
            if let item = self.viewModel.items.first(where: { $0.id == itemId }) {
                cell.configure(with: item)
            }
            return cell
        }
    }

    func applySnapshot(items: [PlayTableCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        if items.isEmpty {
            snapshot.appendItems([-1], toSection: 0)
        } else {
            snapshot.appendItems(items.map { $0.id }, toSection: 0)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension PlayViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataSource.itemIdentifier(for: indexPath) == -1 {
            return 400
        }
        return 113 + 24
    }
}

extension PlayViewController {
    private func updateNavigationUI() {
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

extension PlayViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
