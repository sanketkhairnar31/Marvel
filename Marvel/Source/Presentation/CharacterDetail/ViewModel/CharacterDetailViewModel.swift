//
//  CharacterDetailViewModel.swift
//  Marvel
//
//  Created by Sanket Khairnar on 06/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

protocol CharacterDetailViewModelProtocol {
    typealias Completion = (_ result: Result<Bool, ViewModelError>) -> Void
    
    var name: Observable<String> { get }
    var description: Observable<String> { get }
    var thumbnail: Observable<URL?> { get }
    func fetchCharacterDetail(completion: @escaping Completion)
}

struct CharacterDetailViewModelDependencies {
    let characterDetailUseCase: CharacterDetailUseCaseProtocol?
    let characterId: Int
}

final class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    private var characterDetailUseCase: CharacterDetailUseCaseProtocol?
    private var characterId: Int = 0
    var name: Observable<String> = Observable("")
    var description: Observable<String> = Observable("")
    var thumbnail: Observable<URL?> = Observable(nil)
    
    init(dependancy: CharacterDetailViewModelDependencies) {
        self.characterDetailUseCase = dependancy.characterDetailUseCase
        self.characterId = dependancy.characterId
    }
    
    func fetchCharacterDetail(completion: @escaping Completion) {
        characterDetailUseCase?.getCharacterDetailWith(id: characterId, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characterDetailModel):
                if let detailModel = characterDetailModel {
                    self.name.value = detailModel.name
                    self.description.value = detailModel.description
                    self.thumbnail.value = detailModel.thumbnail
                    completion(.success(true))
                } else {
                    completion(.failure(.characterDetailError))
                }
            case .failure:
                completion(.failure(.characterDetailError))
            }
        })
    }
}
