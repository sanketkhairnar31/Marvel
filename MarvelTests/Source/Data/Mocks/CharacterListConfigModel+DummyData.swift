//
//  CharacterListConfigModelMock.swift
//  Marvel
//
//  Created by Sanket Khairnar on 07/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel

extension CharacterListConfigModel {
    static func validDummyData() -> CharacterListConfigModel {
        return CharacterListConfigModel(offset: 1, limit: 20)
    }
}
