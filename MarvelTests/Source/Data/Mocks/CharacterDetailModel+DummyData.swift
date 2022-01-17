//
//  CharacterDetailModel+DummyData.swift
//  Marvel
//
//  Created by Sanket Khairnar on 08/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation
@testable import Marvel

extension CharacterDetailModel {
    static func validDummyData() -> CharacterDetailModel {
        return CharacterDetailModel(id: 1, name: "Marvel", description: "Marvel Description", thumbnail: URL(string:"www.google.com"))
    }
}
