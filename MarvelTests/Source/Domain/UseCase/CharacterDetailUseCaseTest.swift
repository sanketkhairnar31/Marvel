//
//  CharacterDetailUseCaseTest.swift
//  Marvel
//
//  Created by Sanket Khairnar on 06/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel
import XCTest

final class CharacterDetailUseCaseTest: XCTestCase {
    private var characterDetailUseCase: CharacterDetailUseCaseProtocol?
    private var characterRepository = CharacterRepositoryMock()

    override func setUp() {
        super.setUp()
        let dependancy = CharacterDetailUseCaseDependencies(repository: characterRepository)
        characterDetailUseCase = CharacterDetailUseCase(dependancy: dependancy)
    }

    func testGetCharacterDetailUseCaseWithSuccess() {
        let expectedResult = expectation(description: "Success")
        characterRepository.getCharacterDetail = .success(CharacterDetailModel.validDummyData())
        characterRepository.getCharacterDetail(id:1) { result in
            if case .success = result {
                expectedResult.fulfill()
            }
        }
        wait(for: [expectedResult], timeout: 1)
    }

    func testGetCharacterDetailUseCaseWithFailure() {
        let expectedResult = expectation(description: "Error")
        characterRepository.getCharacterDetail = .failure(.inValidURL)
        characterRepository.getCharacterDetail(id:1) { result in
            if case .failure = result {
                expectedResult.fulfill()
            }
        }
        wait(for: [expectedResult], timeout: 1)
    }
}
