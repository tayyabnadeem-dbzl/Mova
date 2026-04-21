//
//  HomeTapBarController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 16/04/2026.
//

import Foundation
import UIKit

final class HomeTapBarController : UITabBarController {
    private let logoutTag = 1
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.tintColor = .systemRed
        tabBar.unselectedItemTintColor = .gray
        setupTab()
    }
    
    func setupTab() {
        let homeVc = HomeViewBuilder.build()
        let homeNav = UINavigationController(rootViewController: homeVc)
        homeNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "home")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        )
        let logoutVC = UIViewController()
        let logoutNav = UINavigationController(rootViewController: logoutVC)
        logoutNav.tabBarItem = UITabBarItem(
            title: "Logout",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        logoutNav.tabBarItem.tag = logoutTag
        viewControllers = [homeNav, logoutNav]
        selectedViewController = homeNav
    }
    
     func performLogout() {
        SessionManager().clear()
        AppRouter.showLogin()
    }
}

extension HomeTapBarController: UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        guard viewController.tabBarItem.tag == logoutTag else {
            return true
        }
        
        performLogout()
        return false
    }
}
