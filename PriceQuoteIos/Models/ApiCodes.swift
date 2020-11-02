//
//  Errors.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation

public enum Errors: Error {
    case badRequest
    case notFound
}

public enum APIStatusCode: Int {
    case success = 200
    case created = 201
    case badRequest = 400
    case notFound = 404
}
