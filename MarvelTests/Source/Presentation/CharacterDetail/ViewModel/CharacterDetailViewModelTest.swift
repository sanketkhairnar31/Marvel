//
//  CharacterDetailViewModelTest.swift
//  Marvel
//
//  Created by Sanket Khairnar on 07/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//
import Foundation
@testable import Marvel
import XCTest

final class CharacterDetailViewModelTest: XCTestCase {
    private var viewModel: CharacterDetailViewModelProtocol?
    private var detailUseCase = CharacterDetailUseCaseMock()

    override func setUp() {
        super.setUp()
        let dependancy = CharacterDetailViewModelDependencies(characterDeatilsUseCase: detailUseCase,
                                                              characterId: 1017100)
        viewModel = CharacterDetailViewModel(dependancy: dependancy)
    }
    
    func testCharacterDetailSuccess() {
        let expectedResult = expectation(description: "Success")
        detailUseCase.result = .success(CharacterDetailModel.validDummyData())
        detailUseCase.getCharacterDetailWith(id: 1017100, completion: { result in
            if case .success = result {
                expectedResult.fulfill()
            }
        })
        wait(for: [expectedResult], timeout: 1)
    }

    func testCharacterDetailFailure()  {
        let expectedResult = expectation(description: "Error")
        detailUseCase.result = .failure(.inValidURL)
        detailUseCase.getCharacterDetailWith(id: 1017100, completion: { result in
            if case .failure = result {
                expectedResult.fulfill()
            }
        })
        wait(for: [expectedResult], timeout: 1)
    }
}
