//
//  CharacterEntityTest.swift
//  Marvel
//
//  Created by Sanket Khairnar on 06/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel
import XCTest

final class CharacterEntityTest: XCTestCase {
    func testCharacterEntityToDomain() {
        let entity = CharacterEntity(id: 1, name: "Marvel", thumbnail: CharacterImageEntity(path: "www.google.com", fileExtension: "png"))
        let expectedModel = CharacterModel(id: 1, name: "Marvel", thumbnail: URL(string: "www.google.com.png"))
        XCTAssertEqual(try entity.toDomainModel(), expectedModel)
    }

    func testCharacterEntityInvalidId() {
        let entity = CharacterEntity(id: nil, name: "Marvel", thumbnail: CharacterImageEntity(path: "www.google.com", fileExtension: "png"))
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("id", String(describing: context.codingPath[0].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }

    func testCharacterEntityInvalidName() {
        let entity = CharacterEntity(id: 1, name: nil, thumbnail: CharacterImageEntity(path: "www.google.com", fileExtension: "png"))
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("name", String(describing: context.codingPath[1].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }
}

