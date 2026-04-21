//
//  LoginViewBuilder.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 14/04/2026.
//

import Foundation
import UIKit

final class LoginViewBuilder {
    static func build () -> UIViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
            fatalError("Login View Controller not found")
        }
        let store = CoreDataManager.shared
        let session = SessionManager.shared
        let viewModel = LoginViewModel(store: store, session: session)
        vc.viewModel = viewModel
        return vc
    }
}
