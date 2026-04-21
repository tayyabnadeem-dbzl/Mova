//
//  HomeViewModel.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 15/04/2026.
//

import Foundation

protocol HomeViewModelType {
    var numberOfCells: Int { get }
    func cellViewModel(at index: Int) -> CellViewModel
}

final class HomeViewModel: HomeViewModelType {
    private(set) var cellViewModels: [CellViewModel] = []
    var numberOfCells: Int {
        cellViewModels.count
    }
    init() {
        buildLayout()
    }
    func cellViewModel(at index: Int) -> CellViewModel {
        cellViewModels[index]
    }
}

private extension HomeViewModel {

    func buildLayout() {
        guard let data = JSONLoader.loadMovies() else { return }
        var cells: [CellViewModel] = []
        cells.append(BackgroundImageCellViewModel(banner: data.banner))
        data.sections.forEach {
            cells.append(HorizontalCellViewModel(section: $0))
        }
        self.cellViewModels = cells
    }
    
}
