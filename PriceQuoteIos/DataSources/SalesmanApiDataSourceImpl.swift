//
//  SalesmanApiDataSourceImpl.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol SalesmanApiDataSource: class {
    func create(salesman: Salesman, completion: @escaping (BaseCallback<SalesmanBaseResponse>) -> Void)
}

class SalesmanApiDataSourceImpl: SalesmanApiDataSource {
    func create(salesman: Salesman, completion: @escaping (BaseCallback<SalesmanBaseResponse>) -> Void) {
        let url = "http://localhost:3000/api/v1/salesman"
        Alamofire.request(url,
                          method: .post,
                          parameters: salesman.format())
            .responseObject { (response: DataResponse<SalesmanBaseResponse>) in
                APIHandler.handleAPIResponse(data: response, completion: completion)
        }
    }
}

