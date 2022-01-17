//
//  CharacterDetailModel.swift
//  Marvel
//
//  Created by Sanket Khairnar on 02/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

struct CharacterDetailModel: Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: URL?
}
