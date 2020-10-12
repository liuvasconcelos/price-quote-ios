//
//  SalesmanApiDataSourceTests.swift
//  PriceQuoteIosTests
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import PriceQuoteIos

class SalesmanApiDataSourceTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        OHHTTPStubMocks.configureSalesmanStubs()
    }

    func test_create_withCorrectFiels_requestSucceeds() {
        let sut = SalesmanApiDataSourceImpl()
        let salesman = Salesman(name: "Some name",
                                status: SalesmanStatus.active,
                                phone: Phone(number: "999999999",
                                             isWhatsappActive: true))
        let e = expectation(description: "URLSession")
        sut.create(salesman: salesman) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response.id)
                XCTAssertEqual(response.id, 31)
            case .failure(_):
                XCTFail("Fail to save salesman")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_create_withIncorrectFiels_requestFails() {
        OHHTTPStubMocks.isErrorTest = true
        let sut = SalesmanApiDataSourceImpl()
        let salesman = Salesman(name: "",
                                status: SalesmanStatus.active,
                                phone: Phone(number: "999999999",
                                             isWhatsappActive: true))
        let e = expectation(description: "URLSession")
        sut.create(salesman: salesman) { result in
            switch result {
            case .success(_):
                XCTFail("Could save salesman")
            case .failure(let error):
                XCTAssertEqual(error, Errors.badRequest)
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
