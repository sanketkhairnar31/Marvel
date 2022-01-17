//
//  CharacterListModel.swift
//  Marvel
//
//  Created by Sanket Khairnar on 02/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

struct CharacterListModel: Equatable {
    let offset: Int
    let total: Int
    let results: [CharacterModel]
}
