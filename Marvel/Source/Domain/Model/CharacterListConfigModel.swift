//
//  CharacterRequestModel.swift
//  Marvel
//
//  Created by Sanket Khairnar on 02/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

struct CharacterListConfigModel {
    let offset: Int
    let limit: Int
    
    init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
}
