//
//  CharacterDetailUseCaseMock.swift
//  Marvel
//
//  Created by Sanket Khairnar on 08/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel

final class CharacterDetailUseCaseMock: CharacterDetailUseCaseProtocol {
    var result: Result<CharacterDetailModel?, UseCaseError>?

    func getCharacterDetailWith(id: Int, completion: @escaping Completion) {
        guard let result = result else {
            fatalError("CharacterDetailUseCase mock error")
        }
        completion(result)
    }
}
