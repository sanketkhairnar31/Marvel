//
//  CharacterListModel+DummyData.swift
//  Marvel
//
//  Created by Sanket Khairnar on 08/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel

extension CharacterListModel {
    static func validDummyData() -> CharacterListModel {
        return CharacterListModel(offset: 0, total: 100, results: [CharacterModel.validDummyData()])
    }
}
