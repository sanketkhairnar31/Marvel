//
//  CharacterListEntityTest.swift
//  Marvel
//
//  Created by Sanket Khairnar on 06/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel
import XCTest

final class CharacterListEntityTest: XCTestCase {
    func testCharacterListEntityToDomain() {
        let entity = CharacterListEntity(offset: 20, total: 300, results: [CharacterEntity]())
        let expectedModel = CharacterListModel(offset: 20, total: 300, results: [])
        XCTAssertEqual(try entity.toDomainModel(), expectedModel)
    }

    func testCharacterListEntityInvalidOffSet() {
        let entity = CharacterListEntity(offset: nil, total: 300, results: [CharacterEntity]())
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("offset", String(describing: context.codingPath[0].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }

    func testCharacterListEntityInvalidTotal() {
        let entity = CharacterListEntity(offset: 20, total: nil, results: [CharacterEntity]())
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("total", String(describing: context.codingPath[1].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }

    func testCharacterListEntityInvalidResult() {
        let entity = CharacterListEntity(offset: 20, total: 300, results: nil)
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("results", String(describing: context.codingPath[0].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }
}
