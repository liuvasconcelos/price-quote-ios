//
//  SalesmanApiDataSourceImpl.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation

protocol SalesmanApiDataSource: class {
    func create(salesman: Salesman, completion: @escaping(Result<Salesman, Errors>) -> Void)
}

final class SalesmanApiDataSourceImpl: SalesmanApiDataSource {
    private struct K {
        static let createSalesmanPath = "v1/salesman"
    }
    private static var INSTANCE: SalesmanApiDataSourceImpl?
    
    public static func getInstance() -> SalesmanApiDataSourceImpl {
        return INSTANCE ?? SalesmanApiDataSourceImpl()
    }

    func create(salesman: Salesman, completion: @escaping(Result<Salesman, Errors>) -> Void) {
        guard let request = APIHandler.createPostRequest(path: K.createSalesmanPath,
                                                         parameterDictionary: salesman.format()) else {
            return
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let response = try JSONDecoder().decode(SalesmanDataResponse.self, from: data! )
                completion(.success(response.format()))
            } catch {
                completion(.failure(Errors.badRequest))
            }
        }.resume()
    }
}

