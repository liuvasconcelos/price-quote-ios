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
    func test_create_withCorrectFiels_requestSucceeds() {
        let sut = SalesmanApiDataSourceImplMock()
        let salesman = sut.salesman
        let e = expectation(description: "URLSession")
        sut.status = .success
        sut.create(salesman: salesman) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response.id)
            case .failure(_):
                XCTFail("Fail to save salesman")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
