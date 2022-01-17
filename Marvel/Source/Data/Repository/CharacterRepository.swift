////
////  CharacterRepository.swift
////  Marvel
////
////  Created by Sanket Khairnar on 03/12/21.
////  Copyright © 2021 Globant. All rights reserved.
////
//
import Foundation

final class CharacterRepository: CharacterRepositoryProtocol {
    
    var serviceProvider: Provider<CharacterEndPoint>

    convenience init() {
        self.init(serviceProvider: Provider<CharacterEndPoint>())
    }

    init(serviceProvider: Provider<CharacterEndPoint>) {
        self.serviceProvider = serviceProvider
    }

    func getCharacterList(configModel: CharacterListConfigModel, completion: @escaping CharacterListCompletion) {
        let requestEntity = CharacterListConfigEntity(model: configModel)
        serviceProvider.request(.characterList(entity: requestEntity)) { result in
            switch result {
            case .success(let response):
                do {
                    let entity = try response.map(CharacterListEntity.self, atKeyPath: "data")
                    completion(.success(try entity.toDomainModel()))
                } catch {
                    completion(.failure(.mapping(error)))
                }
            case .failure(let error):
                if case let .underlying(_, response) = error, let statusCode = response?.statusCode {
                    switch statusCode {
                    case 400...499:
                        completion(.failure(.marvelApi(.error400(error))))
                    case 500...599:
                        completion(.failure(.marvelApi(.error500(error))))
                    default:
                        completion(.failure(.generic(error)))
                    }
                }
                completion(.failure(.generic(error)))
            }
        }
    }

    func getCharacterDetail(id: Int, completion: @escaping CharacterDetailCompletion) {
        serviceProvider.request(.characterDetail(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let entity = try response.map([CharacterDetailEntity].self, atKeyPath: "data.results").first
                    completion(.success(try entity?.toDomainModel()))
                } catch {
                    completion(.failure(.mapping(error)))
                }
            case .failure(let error):
                if case let .underlying(_, response) = error, let statusCode = response?.statusCode {
                    switch statusCode {
                    case 400...499:
                        completion(.failure(.marvelApi(.error400(error))))
                    case 500...599:
                        completion(.failure(.marvelApi(.error500(error))))
                    default:
                        completion(.failure(.generic(error)))
                    }
                }
                completion(.failure(.generic(error)))
            }
        }
    }
}
