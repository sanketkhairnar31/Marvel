//
//  CharacterEndPoint.swift
//  Marvel
//
//  Created by Sanket Khairnar on 02/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

typealias Parameters = [String : Any]

enum CharacterEndPoint {
    case characterList(entity: CharacterListConfigEntity)
    case characterDetail(id: Int)
}

extension CharacterEndPoint: TargetType {
    var baseURL: URL {
        URL(string: "https://gateway.marvel.com/v1/public")!
    }

    var path: String {
        switch self {
        case .characterList:
            return "/characters"
        case .characterDetail(let id):
            return "/characters/\(id)"
        }
    }

    var method: Method {
        .get
    }

    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    var task: Task {
        switch self {
        case .characterList(let entity):
            var parameters: Parameters = getCommonParameters()
            parameters["limit"] = entity.limit
            parameters["offset"] = entity.offset
            return .requestParameters(parameters: parameters, encoding: encoding)
        case .characterDetail:
            let parameters: Parameters = getCommonParameters()
            return .requestParameters(parameters: parameters, encoding: encoding)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var bundleId: String {
        return "com.Globant.MarvelTests"
    }

    var dataResource: String {
        switch self {
        case .characterList( _):
            return "CharacterList"
        case .characterDetail( _):
            return "CharacterDetail"
        }
    }
    
    var dataExtension: String {
        return "json"
    }

    var sampleData: Data {
        guard let mockBundle = Bundle(identifier: bundleId),
              let url = mockBundle.url(forResource: dataResource, withExtension: dataExtension),
              let data = try? Data(contentsOf: url) else {
            return Data()
        }
        return data
    }
    
    func getCommonParameters() -> Parameters {
        var parameters: Parameters = [:]
        parameters["apikey"] = APIParameters.apiKey
        parameters["hash"] = APIParameters.hash
        parameters["ts"] = 1
        return parameters
    }
}
