//
//  Salesman.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation

struct Salesman {
    let name: String
    let status: SalesmanStatus
    let phone: Phone
    
    func format() -> [String: Any] {
        return [
            "salesman": [
                "name": name,
                "status": status.rawValue,
                "phone": [
                    ["number": phone.number,
                    "whatsapp": phone.isWhatsappActive]
                ]
            ]
        ]
    }
}

struct Phone {
    let number: String
    let isWhatsappActive: Bool
}

public enum SalesmanStatus: String {
    case active = "active"
    case inactive = "inactive"
}
