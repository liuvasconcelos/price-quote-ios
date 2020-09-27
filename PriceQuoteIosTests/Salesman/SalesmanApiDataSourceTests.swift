//
//  SalesmanApiDataSourceTests.swift
//  PriceQuoteIosTests
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import XCTest
@testable import PriceQuoteIos

class SalesmanApiDataSourceTests: XCTestCase {

    func test_create_withCorrectFiels_requestSucceedes() {
        let sut = SalesmanApiDataSourceImplMock()
        let salesman = Salesman(name: "Some name",
                                status: SalesmanStatus.active,
                                phone: Phone(number: "999999999",
                                             isWhatsappActive: true))
        let e = expectation(description: "Alamofire")
        sut.create(salesman: salesman) { result in
            switch result {
            case .success(let saved):
                XCTAssertTrue(saved)
            default: XCTFail("Fail to save salesman")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

class SalesmanApiDataSourceImplMock: SalesmanApiDataSource {
    func create(salesman: Salesman, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
}

