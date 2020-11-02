//
//  APIHandler.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation

class APIHandler {
    public static let basePath = "http://localhost:3000/api/"
    
    public static func createRequest(method: String, path: String, data: Data?) -> URLRequest? {
        guard let url = URL(string: APIHandler.basePath + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        return request
    }

}

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

public enum HttpMethod: String {
    case post, put
}
