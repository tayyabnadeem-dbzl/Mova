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

    func load()
    func updateSearch(query: String)
}

final class SeeAllCollectionViewModel: SeeAllCollectionViewModelType {

    //MARK: - Properties
    let title: String
    private let service: MovieServiceType
    private var allItems: [Character] = []
    var items: [Character] = []
    var onUpdate: (() -> Void)?

    //MARK: - init
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
private extension SeeAllCollectionViewModel {
    func fetchCharacters() async {
        let result = await service.fetchCharactersResult()
        switch result {
        case .success(let characters):
            await handleSuccess(characters)

        case .failure(let error):
            handleError(error)
        }
    }

    @MainActor
    func handleSuccess(_ characters: [Character]) {
        self.allItems = characters
        self.items = characters
        self.onUpdate?()
    }

    func handleError(_ error: NetworkError) {
        print("Error:", error)
    }
    
    internal func updateSearch(query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            items = allItems
        } else {
            items = allItems.filter {
                $0.name.localizedCaseInsensitiveContains(trimmed)
            }
        }
        onUpdate?()
    }
}
