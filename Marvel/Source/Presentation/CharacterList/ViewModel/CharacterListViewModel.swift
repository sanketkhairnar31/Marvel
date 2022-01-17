//
//  CharacterListViewModel.swift
//  Marvel
//
//  Created by Sanket Khairnar on 06/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation
protocol CharacterListViewModelProtocol {
    typealias Completion = (_ result: Result<Bool, ViewModelError>) -> Void

    func fetchCharacterList(completion: @escaping Completion)
    func loadMoreData(completion: @escaping Completion)
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func getCharacterCellViewModel(_ indexPath: IndexPath) -> CharacterCellViewModel
    func navigateToDetailScene(_ fromScreen: CharacterListViewProtocol, indexPath: IndexPath)
}

struct CharacterListViewModelDependencies {
    let characterListUseCase: CharacterListUseCaseProtocol?
}

final class CharacterListViewModel: CharacterListViewModelProtocol {
    private var characterListUseCase: CharacterListUseCaseProtocol?
    
    var characterListDataSource: [CharacterModel] = []
    private var limit = 20
    private var total = 0
    private var isRendering = false
    private var moreDataAvailable = true

    init(dependancy: CharacterListViewModelDependencies) {
        self.characterListUseCase = dependancy.characterListUseCase
    }
        
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return characterListDataSource.count
    }

    func getCharacterCellViewModel(_ indexPath: IndexPath) -> CharacterCellViewModel {
        let characterModel = characterListDataSource[indexPath.row]
        return CharacterCellViewModel(name: characterModel.name, thumbnailURL: characterModel.thumbnail)
    }

    func loadMoreData(completion: @escaping Completion) {
        if !characterListDataSource.isEmpty && characterListDataSource.count < total {
            fetchCharacterList(completion: { result in
                completion(result)
            })
        }
    }
    
    func navigateToDetailScene(_ fromScreen: CharacterListViewProtocol, indexPath: IndexPath) {
        let characterModel = characterListDataSource[indexPath.row]
        Router.sharedInstance.navigate(sceneType: .characterDetail(characterId: characterModel.id), fromScreen: fromScreen)
    }

    func fetchCharacterList(completion: @escaping Completion) {
        guard moreDataAvailable && !isRendering else { return }
        let configModel = CharacterListConfigModel(offset: characterListDataSource.count + 1, limit: limit)
        isRendering = true
        characterListUseCase?.getCharacterList(configModel: configModel, completion: { [weak self] result in
            guard let self = self else { return }
            self.isRendering = false
            switch result {
            case .success(let characterListModel):
                guard !characterListModel.results.isEmpty else { return }
                self.moreDataAvailable = characterListModel.results.count > 0 && characterListModel.results.count == self.limit
                self.total = characterListModel.total
                self.characterListDataSource.append(contentsOf: characterListModel.results)
                completion(.success(true))
            case .failure:
                completion(.failure(.characterListError))
            }
        })
    }
}
