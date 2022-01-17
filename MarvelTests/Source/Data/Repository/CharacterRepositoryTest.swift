//
//  CharacterRepositoryTest.swift
//  Marvel
//
//  Created by Sanket Khairnar on 08/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel
import XCTest

final class CharacterRepositoryTest: XCTestCase {
    private var completion = Provider<CharacterEndPoint>.defaultEndpointMapping
    private let timedOutResponse = EndpointSampleResponse.networkError(NSError(domain: NSURLErrorDomain,
                                                                               code: URLError.timedOut.rawValue,
                                                                               userInfo: nil))

    private func charactersProvider(_ response: EndpointSampleResponse? = nil, stubClosure: @escaping Provider<CharacterEndPoint>
        .StubClosure = Provider.immediatelyStub) -> CharacterRepositoryProtocol {
        if let response = response {
            completion = { (target: CharacterEndPoint) -> Endpoint in
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { response },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
        }
        let serviceProvider = Provider<CharacterEndPoint>(endpointClosure: completion, stubClosure: stubClosure)
        return CharacterRepository(serviceProvider: serviceProvider)
    }
        
    func testGetCharacterListWithSuccess() {
        let expectedResult = expectation(description: "success")
        charactersProvider().getCharacterList(configModel: CharacterListConfigModel.validDummyData()) { result in
            if case .success = result {
                expectedResult.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetCharacterListWithFailure() {
        let expectedResult = expectation(description: "timeoutResponse")
        charactersProvider(timedOutResponse).getCharacterList(configModel: CharacterListConfigModel.validDummyData()) { result in
            if case .failure = result {
                expectedResult.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetCharacterDetailWithSuccess() {
        let expectedResult = expectation(description: "success")
        charactersProvider().getCharacterDetail(id: 1017100) { result in
            if case .success = result {
                expectedResult.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharacterDetailWithFailure() {
        let expectedResult = expectation(description: "Error")
        charactersProvider(timedOutResponse).getCharacterDetail(id: 1017100) { result in
            if case .failure = result {
                expectedResult.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
