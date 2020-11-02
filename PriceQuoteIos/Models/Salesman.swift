//
//  Salesman.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation
 
struct Salesman: Codable {
    var id: Int?
    let name: String
    var status: String?
    //TODO: Api will change!
    var phones: [Phone]?
    var phone: [Phone]?
    
    func requestData() -> Data? {
        let salesmanRequest = SalesmanRequest(salesman: self)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try? encoder.encode(salesmanRequest)
    }
}

struct Phone: Codable {
    var id: Int?
    var number: String?
    var whatsapp: Bool?
}
