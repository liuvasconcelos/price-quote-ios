//
//  APIResponseStatus.swift
//  PriceQuoteIosTests
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation

public enum APIResponseStatus: Error {
    case none
    case success
    case badRequest
    case notFound
}
