//
//  PlayViewModel.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 23/04/2026.
//

import Foundation


protocol PlayViewModelType {
    var items: [PlayTableCellViewModel] { get }
    var onUpdate: (() -> Void)? { get set }
    var title: String {get}

    func load()
    func updateSearch(query: String)
}

final class PlayViewModel: PlayViewModelType {

    //MARK: - Properties
    var title: String
    private let service: MovieServiceType
    private var allItems: [PlayTableCellViewModel] = []
    var items: [PlayTableCellViewModel] = []
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
private extension PlayViewModel {

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
        let mappedItems = characters.map {
            PlayTableCellViewModel(
                id: $0.id,
                title: $0.name,
                date: "12/20/2025",
                episode: "07 Episode",
                status: "Update",
                imageURL: $0.image
            )
        }
        self.allItems = mappedItems
        self.items = mappedItems
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
                $0.title.localizedCaseInsensitiveContains(trimmed)
            }
        }
        onUpdate?()
    }
}
