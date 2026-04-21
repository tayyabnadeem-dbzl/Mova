//
//  AppRouter.swift
//  Mova
//
//  Created by Codex on 21/04/2026.
//

import UIKit

enum AppRouter {
    static func showSplash() {
        guard let window = keyWindow else { return }

        let splashVC = SplashViewBuilder.build()
        let navController = UINavigationController(rootViewController: splashVC)
        setRoot(navController, in: window)
    }

    static func showLogin() {
        guard let window = keyWindow else { return }

        let loginVC = OptionsSignupViewBuilder.build()
        let navController = UINavigationController(rootViewController: loginVC)
        setRoot(navController, in: window)
    }

    static func showHome() {
        guard let window = keyWindow else { return }

        let tabBar = HomeTapBarController()
        setRoot(tabBar, in: window)
    }

    private static var keyWindow: UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }

        for scene in connectedScenes {
            if let sceneDelegate = scene.delegate as? SceneDelegate,
               let window = sceneDelegate.window {
                return window
            }
        }

        return connectedScenes
            .flatMap(\.windows)
            .first(where: \.isKeyWindow)
            ?? connectedScenes.flatMap(\.windows).first
    }

    private static func setRoot(_ viewController: UIViewController, in window: UIWindow) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
