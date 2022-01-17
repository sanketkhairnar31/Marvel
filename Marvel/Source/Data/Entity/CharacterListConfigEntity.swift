//
//  CharacterListConfigEntity.swift
//  Marvel
//
//  Created by Sanket Khairnar on 02/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

struct CharacterListConfigEntity {
    let offset: Int
    let limit: Int

    init(model: CharacterListConfigModel) {
        offset = model.offset
        limit = model.limit
    }
}
