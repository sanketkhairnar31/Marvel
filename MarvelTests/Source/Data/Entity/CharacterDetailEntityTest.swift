//
//  CharacterDetailEntityTest.swift
//  Marvel
//
//  Created by Sanket Khairnar on 06/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel
import XCTest

final class CharacterDetailEntityTest: XCTestCase {
    func testCharacterDetailEntityToDomain() throws {
        let entity = CharacterDetailEntity(id: 1,
                                           name: "Marvel",
                                           description: "Description of Marvel",
                                           thumbnail: CharacterImageEntity(path: "www.google.com", fileExtension: "png"))
        let expectedModel = CharacterDetailModel(id: 1,
                                                 name: "Marvel",
                                                 description: "Description of Marvel",
                                                 thumbnail: URL(string: "www.google.com.png"))
        XCTAssertEqual(try entity.toDomainModel(), expectedModel)
    }

    func testCharacterDetailEntityInvalidID() {
        let entity = CharacterDetailEntity(id: nil,
                                           name: "Marvel",
                                           description: "Description of Marvel",
                                           thumbnail: CharacterImageEntity(path: "www.google.com", fileExtension: "png"))
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("id", String(describing: context.codingPath[0].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }

    func testCharacterDetailEntityInvalidName() {
        let entity = CharacterDetailEntity(id: 1,
                                           name: nil,
                                           description: "Description of Marvel",
                                           thumbnail: CharacterImageEntity(path: "www.google.com", fileExtension: "png"))
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("name", String(describing: context.codingPath[1].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }
}
