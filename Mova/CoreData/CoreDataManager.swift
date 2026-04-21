//
//  CoreDataManager.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 14/04/2026.
//

import CoreData

protocol storeType {
    func fetchUser(email: String, password: String) -> User?
    func saveUser(email: String, password: String)
    func userExists(email: String) -> Bool
    func fetchAllUsers() -> [User]
}

final class CoreDataManager: storeType {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
     init() {
        container = NSPersistentContainer(name: "MovaCoreData")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData failed: \(error)")
            }
        }
    }

    func fetchUser(email: String, password: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(
            format: "email == %@ AND password == %@",
            email, password
        )
        return try? context.fetch(request).first
    }

    func userExists(email: String) -> Bool {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        return (try? context.count(for: request)) ?? 0 > 0
    }

    func saveUser(email: String, password: String) {
        let user = User(context: context)
        user.email = email
        user.password = password
        try? context.save()
    }

    func fetchAllUsers() -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch Failed \(error)")
            return []
        }
    }

}

// MARK: - SessionManaging
protocol SessionManaging {
    func saveUser(email: String)
    func getUser() -> String?
    func clear()
}

// MARK: - SessionManager
final class SessionManager: SessionManaging {

    static let shared = SessionManager()
     init() {}

    func saveUser(email: String) {
        UserDefaults.standard.set(email, forKey: StorageKeys.loggedInUser)
        print("Logged in user:", UserDefaults.standard.string(forKey: StorageKeys.loggedInUser) ?? "nil")
    }

    func getUser() -> String? {
        UserDefaults.standard.string(forKey: StorageKeys.loggedInUser)
    }

    func clear() {
        print("before clear Logged in user:", UserDefaults.standard.string(forKey: StorageKeys.loggedInUser) ?? "nil")
        UserDefaults.standard.removeObject(forKey: StorageKeys.loggedInUser)
        print("before clear Logged in user:", UserDefaults.standard.string(forKey: StorageKeys.loggedInUser) ?? "nil")

    }
}
