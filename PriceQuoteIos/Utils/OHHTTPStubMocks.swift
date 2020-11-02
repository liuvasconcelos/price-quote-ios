//
//  OHHTTPStubMocks.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 12/10/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import OHHTTPStubs
import UIKit

public class OHHTTPStubMocks {
    public static var isErrorTest = false
    
    public static func configureSalesmanStubs() {
        createSalesmanSuccess()
    }
    
    private static func createSalesmanSuccess() {
        HTTPStubs.stubRequests(passingTest: { request -> Bool in
            let createSalemanUri = APIHandler.basePath + "v1/salesman"
            return request.url?.absoluteString == createSalemanUri
        }, withStubResponse: { _ -> HTTPStubsResponse in
            if isErrorTest {
                return HTTPStubsResponse(fileAtPath: OHPathForFile("createSalesmanBadRequest.json", self)!,
                                         statusCode: 400,
                                         headers: nil)
            }
            return HTTPStubsResponse(fileAtPath: OHPathForFile("createSalesman.json", self)!,
                                     statusCode: 201,
                                     headers: nil)
        })
    }
}

