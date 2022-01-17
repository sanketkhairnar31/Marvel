//
//  CharacterDetailUseCase.swift
//  Marvel
//
//  Created by Sanket Khairnar on 03/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

protocol CharacterDetailUseCaseProtocol: AnyObject {
    typealias Completion = (_ result: Result<CharacterDetailModel?, UseCaseError>) -> Void
    func getCharacterDetailWith(id: Int, completion: @escaping Completion)
}

struct CharacterDetailUseCaseDependencies {
    let repository: CharacterRepositoryProtocol?
}

final class CharacterDetailUseCase: CharacterDetailUseCaseProtocol {
    private var repository: CharacterRepositoryProtocol?

    init(repository: CharacterRepositoryProtocol?) {
        self.repository = repository
    }
    
    convenience init(dependancy: CharacterDetailUseCaseDependencies) {
        self.init(repository: dependancy.repository)
    }

    func getCharacterDetailWith(id: Int, completion: @escaping Completion) {
        repository?.getCharacterDetail(id: id, completion: completion)
    }
}
