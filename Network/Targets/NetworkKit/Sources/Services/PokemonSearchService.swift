//
//  PokemonSearchService.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

import Moya
import Result

protocol PokemonSearchLoadingService: class {
    var provider: MoyaProvider<PokemonSearchEndpoint> { get }
    
    func search(identifier: Int, completion: @escaping (_ data: Data?, _ error: String?) -> Void)
}

class PokemonSearchService: PokemonSearchLoadingService {
    // swiftlint:disable force_unwrapping
    let customEndpointClosure = { (target: PokemonSearchEndpoint) -> Endpoint in
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(401, "Not authorized".data(using: .utf8)!) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    var provider: MoyaProvider<PokemonSearchEndpoint> {
        
        if Configuration.authenticationErrorTesting {
            return MoyaProvider<PokemonSearchEndpoint>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        } else if Configuration.uiTesting == true {
            return MoyaProvider<PokemonSearchEndpoint>(stubClosure: MoyaProvider.immediatelyStub)
        } else if Configuration.networkTesting {
            return MoyaProvider<PokemonSearchEndpoint>(plugins: [NetworkLoggerPlugin()])
        } else {
            return MoyaProvider<PokemonSearchEndpoint>(callbackQueue: DispatchQueue.global(qos: .background))
        }
    }
    
    func search(identifier: Int, completion: @escaping (_ data: Data?, _ error: String?) -> Void) {
        provider.request(.search(identifier: identifier)) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 404 {
                    completion(nil, Constants.Translations.Error.statusCode404)
                    return
                }
                
                if 200 ..< 300 ~= response.statusCode {
                    completion(response.data, nil)
                } else {
                    completion(nil, "Error: \(response.statusCode)")
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
