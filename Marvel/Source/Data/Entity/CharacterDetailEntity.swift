//
//  CharacterDetailEntity.swift
//  Marvel
//
//  Created by Sanket Khairnar on 02/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

struct CharacterDetailEntity: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: CharacterImageEntity?
    
    func toDomainModel() throws -> CharacterDetailModel {
        guard let id = id, let name = name, let thumbnail = thumbnail else {
            throw DecodingError.valueNotFound(CharacterDetailEntity.self,
                                              DecodingError.Context(codingPath: [CharacterDetailEntity.CodingKeys.id,
                                                                                 CharacterDetailEntity.CodingKeys.name,
                                                                                 CharacterDetailEntity.CodingKeys.thumbnail],
                                                                    debugDescription: "Failed to decode \(CharacterDetailEntity.self)"))
        }

        // description can be nil for some characters
        return CharacterDetailModel(id: id, name: name, description: description ?? "", thumbnail: try thumbnail.toDomainModel())
    }
}
