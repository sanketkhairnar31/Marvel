//
//  CharacterRepositoryMock.swift
//  Marvel
//
//  Created by Sanket Khairnar on 08/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel

final class CharacterRepositoryMock: CharacterRepositoryProtocol {
    var getCharacterList: Result<CharacterListModel, UseCaseError>?
    var getCharacterDetail: Result<CharacterDetailModel?, UseCaseError>?

    func getCharacterList(configModel: CharacterListConfigModel, completion: @escaping CharacterListCompletion) {
        guard let result = getCharacterList else {
            fatalError("getCharacterList mock error")
        }
        completion(result)
    }

    func getCharacterDetail(id: Int, completion: @escaping CharacterDetailCompletion) {
        guard let result = getCharacterDetail else {
            fatalError("getCharacterDetail mock error")
        }
        completion(result)
    }
}
