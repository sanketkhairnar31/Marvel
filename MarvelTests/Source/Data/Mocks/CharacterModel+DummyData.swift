//
//  CharacterModel+DummyData.swift
//  Marvel
//
//  Created by Sanket Khairnar on 07/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

@testable import Marvel

extension CharacterModel {
    static func validDummyData() -> CharacterModel {
        return CharacterModel(id: 1009144, name: "Marvel", thumbnail: nil)
    }
}
