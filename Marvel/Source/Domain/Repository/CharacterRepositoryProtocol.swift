//
//  CharacterRepositoryProtocol.swift
//  Marvel
//
//  Created by Sanket Khairnar on 03/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

protocol CharacterRepositoryProtocol {
    typealias CharacterListCompletion = (_ result: Result<CharacterListModel, UseCaseError>) -> Void
    typealias CharacterDetailCompletion = (_ result: Result<CharacterDetailModel?, UseCaseError>) -> Void

    func getCharacterList(configModel: CharacterListConfigModel, completion: @escaping CharacterListCompletion)
    func getCharacterDetail(id: Int, completion: @escaping CharacterDetailCompletion)
}
