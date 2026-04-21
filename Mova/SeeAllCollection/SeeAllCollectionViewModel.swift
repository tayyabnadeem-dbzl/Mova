//
//  SeeAllCollectionViewModel.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 17/04/2026.
//

import Foundation

protocol SeeAllCollectionViewModelType {
    var title: String { get }
    var items: [Character] { get }
    var onUpdate: (() -> Void)? { get set }

    func fetchCharacters() async
    func load()
}

final class SeeAllCollectionViewModel: SeeAllCollectionViewModelType {

    let title: String
    private let service: MovieServiceType
    var items: [Character] = []
    var onUpdate: (() -> Void)?

    init(title: String, service: MovieServiceType) {
        self.title = title
        self.service = service
    }
    
    func load() {
        Task {
            await fetchCharacters()
        }
    }
}

//MARK: - API

extension SeeAllCollectionViewModel {
    func fetchCharacters() async {
        do {
            let result = try await service.fetchCharacters()
            self.items = result

            DispatchQueue.main.async {
                self.onUpdate?()
            }
        } catch {
            print("Error:", error)
        }
    }
}
