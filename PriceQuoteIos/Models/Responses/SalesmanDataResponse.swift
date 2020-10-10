//
//  SalesmanDataResponse.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 10/10/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation

struct SalesmanDataResponse: Codable {
    let data: SalesmanResponse?
    let status: Int?
    
    func format() -> Salesman {
        let phone = Phone(id: data?.phones?.first?.id,
                          number: data?.phones?.first?.number ?? String(),
                          isWhatsappActive: data?.phones?.first?.whatsapp ?? false)
        return Salesman(id: data?.id,
                        name: data?.name ?? String(),
                        status: SalesmanStatus(rawValue: data?.status ?? "inactive") ?? SalesmanStatus.inactive,
                        phone: phone)
    }
}

struct SalesmanResponse: Codable {
    let id: Int?
    let name, status: String?
    let phones: [PhoneResponse]?
}

struct PhoneResponse: Codable {
    let id: Int?
    let number: String?
    let whatsapp: Bool?
}
