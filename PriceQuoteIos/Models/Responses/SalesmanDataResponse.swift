//
//  SalesmanDataResponse.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 10/10/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation

struct SalesmanDataResponse: Codable {
    let data: Salesman?
    let status: Int?
}

struct SalesmanRequest: Codable {
    let salesman: Salesman?
    
}
