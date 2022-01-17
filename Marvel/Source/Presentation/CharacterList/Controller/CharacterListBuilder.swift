//
//  CharacterListBuilder.swift
//  Marvel
//
//  Created by Sanket Khairnar on 14/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation
import UIKit

final class CharacterListBuilder {
    func build() -> CharacterListController {
        let useCase = CharacterListUseCase(repository: CharacterRepository())
        let dependancies = CharacterListViewModelDependencies(characterListUseCase: useCase)
        let viewModel = CharacterListViewModel(dependancy: dependancies)
        let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "CharacterListController", creator: { coder -> CharacterListController? in
            CharacterListController(coder: coder, viewModel: viewModel)
        })
        return viewController
    }
}
