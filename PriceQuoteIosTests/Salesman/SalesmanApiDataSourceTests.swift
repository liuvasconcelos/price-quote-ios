//
//  SalesmanApiDataSourceTests.swift
//  PriceQuoteIosTests
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import OHHTTPStubs
import Quick
import Nimble
@testable import PriceQuoteIos

class SalesmanApiDataSourceTests: QuickSpec {
    var sut: SalesmanApiDataSource!
    var salesman: Salesman!
    
    override func spec() {
        super.spec()
        OHHTTPStubMocks.configureSalesmanStubs()
        sut = SalesmanApiDataSourceImpl()
        
        afterEach {
            OHHTTPStubMocks.isErrorTest = false
        }
        
        describe("creating a salesman") {
            context("when request succeeds") {
                var savedSalesman: Salesman?
                
                beforeEach {
                    self.salesman = Salesman(name: "Some name",
                                             status: "active",
                                             phone: [Phone(number: "999999999",
                                                          whatsapp: true)])
                    let e = self.expectation(description: "URLSession")
                    self.sut.create(salesman: self.salesman) { result in
                        switch result {
                        case .success(let response):
                            savedSalesman = response
                        case .failure(_):
                            fail("Fail to save salesman")
                        }
                        e.fulfill()
                    }
                    self.waitForExpectations(timeout: 5.0, handler: nil)
                }
            
                it("should save salesman correctly") {
                    expect(savedSalesman?.id).toNot(beNil())
                    expect(savedSalesman?.id).to(equal(31))
                }
            }
            
            context("when request fails") {
                var errorResponse: Errors?
                
                beforeEach {
                    OHHTTPStubMocks.isErrorTest = true
                    self.salesman = Salesman(name: "",
                                             status: "active",
                                             phone: [Phone(number: "999999999",
                                                          whatsapp: true)])
                    let e = self.expectation(description: "URLSession")
                    self.sut.create(salesman: self.salesman) { result in
                        switch result {
                        case .success(_):
                            fail("Could save salesman")
                        case .failure(let error):
                            errorResponse = error
                        }
                        e.fulfill()
                    }
                    self.waitForExpectations(timeout: 5.0, handler: nil)
                }
                
                it("should get an error") {
                    expect(errorResponse).to(equal(Errors.badRequest))
                }
            }
        }
        
        describe("updating a salesman") {
            context("when request succeeds") {
                var didUpdate: Bool?
                
                beforeEach {
                    self.salesman = Salesman(id: 50,
                                             name: "Some updated name",
                                             status: "active")
                    let e = self.expectation(description: "URLSession")
                    self.sut.update(salesman: self.salesman) { result in
                        switch result {
                        case .success(let response):
                            didUpdate = response
                        case .failure(_):
                            fail("Fail to update salesman")
                        }
                        e.fulfill()
                    }
                    self.waitForExpectations(timeout: 5.0, handler: nil)
                }
            
                it("should update salesman correctly") {
                    expect(didUpdate).to(beTrue())
                }
            }
            
            context("when tries to update a non-existent salesman and request fails") {
                var errorResponse: Errors?

                beforeEach {
                    OHHTTPStubMocks.isErrorTest = true
                    self.salesman = Salesman(id: 500,
                                             name: "Non-existent")
                    let e = self.expectation(description: "URLSession")
                    self.sut.update(salesman: self.salesman) { result in
                        switch result {
                        case .success(_):
                            fail("Could update salesman")
                        case .failure(let error):
                            errorResponse = error
                        }
                        e.fulfill()
                    }
                    self.waitForExpectations(timeout: 5.0, handler: nil)
                }

                it("should get an error") {
                    expect(errorResponse).to(equal(Errors.notFound))
                }
            }
        }
    }
}
