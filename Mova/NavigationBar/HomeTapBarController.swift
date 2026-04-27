//
//  HomeTapBarController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 16/04/2026.
//

import Foundation
import UIKit

final class HomeTapBarController : UITabBarController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let profileVC = ProfileViewBuilder.build()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        viewControllers = [homeNav, profileNav]
        selectedViewController = homeNav
    }
    
     func performLogout() {
         SessionManager.shared.clear()
        AppRouter.showLogin()
    }
}


