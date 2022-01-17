//
//  CharacterImageEntityTest.swift
//  Marvel
//
//  Created by Sanket Khairnar on 06/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel
import XCTest

final class CharacterImageEntityTest: XCTestCase {
    func testCharacterImageEntityToDomain() {
        let entity = CharacterImageEntity(path: "www.google.com", fileExtension: "png")
        let expectedURL = URL(string: "www.google.com.png")
        XCTAssertEqual(try entity.toDomainModel(), expectedURL)
    }
}
