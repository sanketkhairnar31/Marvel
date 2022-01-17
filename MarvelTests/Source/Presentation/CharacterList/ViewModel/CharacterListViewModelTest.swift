//
//  CharacterListViewModelTest.swift
//  Marvel
//
//  Created by Sanket Khairnar on 07/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel
import XCTest

final class CharacterListViewModelTest: XCTestCase {
    private var viewModel: CharacterListViewModelProtocol?
    private var listUseCase = CharacterListUseCaseMock()

    override func setUp() {
        super.setUp()
        let dependancy = CharacterListViewModelDependencies(characterListUseCase: listUseCase)
        viewModel = CharacterListViewModel(dependancy: dependancy)
    }
    
    func testCharacterDetailSuccess() {
        let expectedResult = expectation(description: "Success")
        listUseCase.result = .success(CharacterListModel.validDummyData())
        listUseCase.getCharacterList(configModel: CharacterListConfigModel.validDummyData(), completion: { result in
            if case .success = result {
                expectedResult.fulfill()
            }
        })
        wait(for: [expectedResult], timeout: 1)
    }

    func testCharacterDetailFailure()  {
        let expectedResult = expectation(description: "Error")
        listUseCase.result = .failure(.inValidURL)
        listUseCase.getCharacterList(configModel: CharacterListConfigModel.validDummyData(), completion: { result in
            if case .failure = result {
                expectedResult.fulfill()
            }
        })
        wait(for: [expectedResult], timeout: 1)
    }
}
