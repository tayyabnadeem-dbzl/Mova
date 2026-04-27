//
//  HomeViewController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 14/04/2026.
//

import Foundation
import UIKit

private enum HomeRow: Int, CaseIterable {
    case BackgroundImageCellController
    case HorizontalCollectionCellController
}

final class HomeViewController : UIViewController, HorizontalCollectionCellControllerDelegate{
    
    //MARK: - Outlets
    @IBOutlet weak var mainStackVIew: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navbarStackView: UIStackView!
    @IBOutlet weak var appLogoImageView: UIImageView!
    @IBOutlet weak var searchbarLogoImageView: UIImageView!
    @IBOutlet weak var notificationLogoImageView: UIImageView!
    
    //MARK: - Properties
    var viewModel: HomeViewModelType!
    private let navbarBlurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(mainStackVIew)
        setupTableView()
        setupNavbarBlur()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

//MARK: - Setup
private extension HomeViewController {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "BackgroundImageCellController", bundle: nil),
        forCellReuseIdentifier: "BackgroundImageCellController")
        tableView.register(UINib(nibName: "HorizontalCollectionCellController", bundle: nil),
        forCellReuseIdentifier: "HorizontalCollectionCellController")
        mainStackVIew.backgroundColor = .clear
        appLogoImageView.image = UIImage(named: "mova-icon")
        notificationLogoImageView.image = UIImage(named: "notification")
        searchbarLogoImageView.image = UIImage(named: "search")
        mainStackVIew.layer.shadowColor = UIColor.black.cgColor
        mainStackVIew.layer.shadowOpacity = 0.25
        mainStackVIew.layer.shadowRadius = 8
        mainStackVIew.layer.cornerRadius = 100
        mainStackVIew.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}

extension HomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.cellViewModel(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(
            withIdentifier: vm.reuseIdentifier,
            for: indexPath
        )
        switch vm {
        case let bannerVM as BackgroundImageCellViewModel:
            if let cell = cell as? BackgroundImageCellController {
                cell.configure(with: bannerVM)
                cell.delegate = self
            }
        case let horizontalVM as HorizontalCellViewModel:
            if let cell = cell as? HorizontalCollectionCellController {
                cell.configure(with: horizontalVM)
                cell.delegate = self
                cell.title = horizontalVM.title
            }
        default:
            assertionFailure("Unknown CellViewModel type: \(vm)")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let vm = viewModel.cellViewModel(at: indexPath.row)
        switch vm {
        case is BackgroundImageCellViewModel:
            return 400

        case is HorizontalCellViewModel:
            return 248 + 24

        default:
            return 0
        }
    }
}

extension HomeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let progress = min(max(offset / 120, 0), 1)
        navbarBlurView.alpha = progress
        mainStackVIew.backgroundColor = UIColor.black.withAlphaComponent(0.15 * progress)
    }
    
    private func setupNavbarBlur() {
        navbarBlurView.frame = mainStackVIew.bounds
        navbarBlurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navbarBlurView.alpha = 0
        mainStackVIew.insertSubview(navbarBlurView, at: 0)
    }
}

//MARK: - Actions
extension HomeViewController {
    func didTapSeeAll(title: String, items: [MovieItem]) {
        let vc = SeeAllCollectionViewBuilder.build(title: title)
        navigationController?.pushViewController(vc, animated: true)
    }
}

private extension HomeViewController {
    func navigateToLogin() {
       AppRouter.showLogin()
   }
}
extension HomeViewController: BackgroundImageCellControllerDelegate {

    func didTapPlay() {
        let vc = PlayViewBuilder.build(title: "Play")
        navigationController?.pushViewController(vc, animated: true)
    }
}
