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
        let salesman = sut.salesman
        let e = expectation(description: "Alamofire")
        sut.status = .success
        sut.create(salesman: salesman) { result in
            result.onSuccess { response in
                XCTAssertEqual(response.salesman?.name, salesman.name)
            }
            result.onFailed { error in
                XCTFail("Fail to save salesman")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

class SalesmanApiDataSourceImplMock: SalesmanApiDataSource {
    let salesman = Salesman(name: "Some name",
                            status: SalesmanStatus.active,
                            phone: Phone(number: "999999999",
                                         isWhatsappActive: true))
    let json = """
            {"data":{"id":24,"name":"Some name","status":"ativo","phones":[{"id":12,"number":"999999999","whatsapp":true}]},"status":201}
            """
    var status: APIResponseStatus = .none
    
    func create(salesman: Salesman, completion: @escaping (BaseCallback<SalesmanBaseResponse>) -> Void) {
        switch status {
        case .success:
            completion(BaseCallback.success(SalesmanBaseResponse(JSONString: json)!))
        default:
            completion(BaseCallback.failed())
        }
        
    }
}

