//
//  NetworkError.swift
//  Marvel
//
//  Created by Sanket Khairnar on 03/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case generic(Error)
    case inValidUrl
    case invalidResponse
    case noData
    case unknown
}

enum UseCaseError: Error {
    case mapping(Swift.Error)
    case timeout(Swift.Error)
    case noConnection(Swift.Error)
    case marvelApi(MarvelApiError)
    case generic(Swift.Error)
    case inValidURL
}

enum MarvelApiError: Error {
    case error400(Swift.Error)
    case error500(Swift.Error)
}

enum ViewModelError: Error {
    case characterListError
    case characterDetailError
    
    var errorDescription: String {
        switch self {
        case .characterListError:
            return "character_list_error".localizedString()
        case .characterDetailError:
            return "character_detail_error".localizedString()
        }
    }
}
