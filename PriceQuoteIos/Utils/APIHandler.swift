//
//  APIHandler.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation

class APIHandler {
    public static func createPostRequest(path: String, parameterDictionary: [String: Any]) -> URLRequest? {
        guard let url = URL(string: path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return nil
        }
        request.httpBody = httpBody
        return request
    }
}
