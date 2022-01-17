//
//  Router.swift
//  Marvel
//
//  Created by Sanket Khairnar on 07/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation
import UIKit

enum SceneType {
    case characterList
    case characterDetail(characterId: Int)
}

final class Router {
    private init() { }
    static let sharedInstance: Router = Router()

    func navigate(sceneType: SceneType, fromScreen: ViewProtocol) {
        switch sceneType {
        case let .characterDetail(characterId):
            let navigationController = (fromScreen as? UIViewController)?.navigationController
            let viewController = CharacterDetailBuilder().build(characterId)
            navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }
    }
}
