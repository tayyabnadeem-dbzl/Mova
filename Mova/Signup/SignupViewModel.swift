//
//  SignupViewModel.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 13/04/2026.
//

import Foundation
import CoreData

protocol SignupViewModelType {
    var onSignupSuccess: ((String) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    
    func signup(email: String, password: String)
}

final class SignupViewModel: SignupViewModelType {

    var onSignupSuccess: ((String) -> Void)?
    var onError: ((String) -> Void)?

    private let store: storeType
    private let session: SessionManaging

    init(store: storeType, session: SessionManaging) {
        self.store = store
        self.session = session
    }

    func signup(email: String, password: String) {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !email.isEmpty, !password.isEmpty else {
            onError?("Fields cannot be empty")
            return
        }
        guard !store.userExists(email: email) else {
            onError?("User already exists")
            return
        }
        store.saveUser(email: email, password: password)
        session.saveUser(email: email)
        onSignupSuccess?(email)
    }
}
