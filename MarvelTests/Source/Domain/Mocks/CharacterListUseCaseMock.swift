//
//  CharacterListUseCaseMock.swift
//  Marvel
//
//  Created by Sanket Khairnar on 08/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel

final class CharacterListUseCaseMock: CharacterListUseCaseProtocol {
    var result: Result<CharacterListModel, UseCaseError>?

    func getCharacterList(configModel: CharacterListConfigModel, completion: @escaping Completion) {
        guard let result = result else {
            fatalError("CharacterListUseCase mock error")
        }
        completion(result)
    }
}
