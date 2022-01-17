//
//  CharacterListUseCase.swift
//  Marvel
//
//  Created by Sanket Khairnar on 03/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

protocol CharacterListUseCaseProtocol: AnyObject {
    typealias Completion = (_ result: Result<CharacterListModel, UseCaseError>) -> Void
    func getCharacterList(configModel: CharacterListConfigModel, completion: @escaping Completion)
}

struct CharacterListUseCaseDependencies {
    let repository: CharacterRepositoryProtocol?
}

final class CharacterListUseCase: CharacterListUseCaseProtocol {
    private var repository: CharacterRepositoryProtocol?

    init(repository: CharacterRepositoryProtocol?) {
        self.repository = repository
    }
    
    convenience init(dependancy: CharacterListUseCaseDependencies) {
        self.init(repository: dependancy.repository)
    }

    func getCharacterList(configModel: CharacterListConfigModel, completion: @escaping Completion) {
        repository?.getCharacterList(configModel: configModel, completion: completion)
    }
}
