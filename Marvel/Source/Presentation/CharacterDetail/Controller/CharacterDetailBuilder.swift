//
//  CharacterDetailBuilder.swift
//  Marvel
//
//  Created by Sanket Khairnar on 14/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation
import UIKit

final class CharacterDetailBuilder {
    func build(_ characterId: Int) -> CharacterDetailController {
        let useCase = CharacterDetailUseCase(repository: CharacterRepository())
        let dependancies = CharacterDetailViewModelDependencies(characterDetailUseCase: useCase, characterId: characterId)
        let viewModel = CharacterDetailViewModel(dependancy: dependancies)
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CharacterDetailController", creator: { coder -> CharacterDetailController? in
            CharacterDetailController(coder: coder, viewModel: viewModel)
        })
        return viewController
    }
}
