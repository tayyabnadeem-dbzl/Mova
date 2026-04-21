//
//  SignupViewBuilder.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 13/04/2026.
//

import Foundation
import UIKit

final class SignupViewBuilder {
    static func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else {
            fatalError("viewcontroller not found")
            
        }
        let store = CoreDataManager.shared
        let session = SessionManager.shared
        let viewModel = SignupViewModel(store: store, session: session)
        vc.viewModel = viewModel
        return vc
    }
}
