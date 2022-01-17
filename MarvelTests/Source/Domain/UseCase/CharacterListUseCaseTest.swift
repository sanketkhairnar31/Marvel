//
//  CharacterListUseCaseTest.swift
//  Marvel
//
//  Created by Sanket Khairnar on 06/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel
import XCTest

final class CharacterListUseCaseTest: XCTestCase {
    private var characterListUseCase: CharacterListUseCaseProtocol?
    private var characterRepository = CharacterRepositoryMock()

    override func setUp() {
        super.setUp()
        let dependancy = CharacterListUseCaseDependencies(repository: characterRepository)
        characterListUseCase = CharacterListUseCase(dependancy: dependancy)
    }

    func testGetCharacterListUseCaseWithSuccess() {
        let expectedResult = expectation(description: "Success")
        characterRepository.getCharacterList = .success(CharacterListModel.validDummyData())
        characterRepository.getCharacterList(configModel: CharacterListConfigModel.validDummyData()) { result in
            if case .success = result {
                expectedResult.fulfill()
            }
        }
        wait(for: [expectedResult], timeout: 1)
    }

    func testGetCharacterListUseCaseWithFailure() {
        let expectedResult = expectation(description: "Error")
        characterRepository.getCharacterList = .failure(.inValidURL)
        characterRepository.getCharacterList(configModel: CharacterListConfigModel.validDummyData()) { result in
            if case .failure = result {
                expectedResult.fulfill()
            }
        }
        wait(for: [expectedResult], timeout: 1)
    }
}
