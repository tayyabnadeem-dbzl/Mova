//
//  LoginViewModel.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 14/04/2026.
//

import Foundation
import CoreData

protocol LoginViewModelType {
    var onLoginSuccess: ((String) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    func login(email: String, password: String)
}

final class LoginViewModel: LoginViewModelType {

    var onLoginSuccess: ((String) -> Void)?
    var onError: ((String) -> Void)?
    private let store: storeType
    private let session: SessionManaging
    
    init(store: storeType, session: SessionManaging) {
        self.store = store
        self.session = session
    }

    func login(email: String, password: String) {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !email.isEmpty, !password.isEmpty else {
            onError?("Fields cannot be empty")
            return
        }
        guard let user = store.fetchUser(email: email, password: password) else {
            onError?("Invalid credentials")
            return
        }
        guard let savedEmail = user.email?.trimmingCharacters(in: .whitespacesAndNewlines),
              !savedEmail.isEmpty else {
            onError?("Stored user email is invalid")
            return
        }
        session.saveUser(email: savedEmail)
        onLoginSuccess?(savedEmail)
    }
}
