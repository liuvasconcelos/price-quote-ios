//
//  SalesmanApiDataSourceImpl.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation
import Alamofire

protocol SalesmanApiDataSource: class {
    func create(salesman: Salesman, completion: @escaping (Result<Bool, Error>) -> Void)
}

class SalesmanApiDataSourceImpl: SalesmanApiDataSource {
    func create(salesman: Salesman, completion: @escaping (Result<Bool, Error>) -> Void) {
        AF.request("http://localhost:3000/api/v1/salesman",
                   method:.post,
                   parameters: salesman.format(),
                   encoding: JSONEncoding.default).responseJSON { (response) in
                    switch response.result {
                    case .success (let data):
                        APIHandler.handleAPIResponse(data: data, completion: completion)
                    case .failure(let error):
                        completion(.failure(error))
                    }
        }
        
    }
}

class APIHandler {
    public static func handleAPIResponse(data: Any,
                                         completion: @escaping (Result<Bool, Error>) -> Void) {
        if let dictionary = data as? [String: Any],
            let status = dictionary["status"] as? Int {
            switch status {
            case 201:
                completion(.success(true))
            case 404:
                completion(.failure(Errors.notFound))
            default:
                completion(.failure(Errors.badRequest))
            }
        } else {
            completion(.failure(Errors.badRequest))
        }
    }
}
