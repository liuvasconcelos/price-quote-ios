//
//  SalesmanApiDataSourceImplMock.swift
//  PriceQuoteIosTests
//
//  Created by Livia Vasconcelos on 10/10/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation
@testable import PriceQuoteIos

class SalesmanApiDataSourceImplMock: SalesmanApiDataSource {
    let salesman = Salesman(name: "Some name",
                            status: SalesmanStatus.active,
                            phone: Phone(number: "999999999",
                                         isWhatsappActive: true))
    var status: APIResponseStatus = .none

    func create(salesman: Salesman, completion: @escaping (Result<Salesman, Errors>) -> Void) {
        switch status {
        case .success:
            let salesmanResponse = Salesman(id: 1,
                                            name: salesman.name,
                                            status: salesman.status,
                                            phone: salesman.phone)
            completion(.success(salesmanResponse))
        default:
            completion(.failure(Errors.badRequest))
        }
    }
}
