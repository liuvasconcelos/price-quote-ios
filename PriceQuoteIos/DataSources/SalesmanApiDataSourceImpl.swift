//
//  SalesmanApiDataSourceImpl.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation

protocol SalesmanApiDataSource: class {
    func create(salesman: Salesman, completion: @escaping(Result<Salesman?, Errors>) -> Void)
    func update(salesman: Salesman, completion: @escaping(Result<Bool?, Errors>) -> Void)
}

final class SalesmanApiDataSourceImpl: SalesmanApiDataSource {
    private struct K {
        static let createSalesmanPath = "v1/salesman"
    }
    private static var INSTANCE: SalesmanApiDataSourceImpl?
    
    public static func getInstance() -> SalesmanApiDataSourceImpl {
        return INSTANCE ?? SalesmanApiDataSourceImpl()
    }

    func create(salesman: Salesman, completion: @escaping(Result<Salesman?, Errors>) -> Void) {
        guard let request = APIHandler.createRequest(method: "POST",
                                                     path: K.createSalesmanPath,
                                                     data: salesman.requestData()) else {
            return
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let response = try JSONDecoder().decode(SalesmanDataResponse.self, from: data!)
                completion(.success(response.data))
            } catch {
                completion(.failure(Errors.badRequest))
            }
        }.resume()
    }

    func update(salesman: Salesman, completion: @escaping(Result<Bool?, Errors>) -> Void) {
        let updatePath = "\(K.createSalesmanPath)/\(String(salesman.id ?? 0))"
        guard let request = APIHandler.createRequest(method: "PUT",
                                                     path: updatePath,
                                                     data: salesman.requestData()) else {
            return
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let r = response as? HTTPURLResponse, r.statusCode == APIStatusCode.success.rawValue {
                completion(.success(true))
            } else {
                completion(.failure(Errors.notFound))
            }
        }.resume()
    }
}

