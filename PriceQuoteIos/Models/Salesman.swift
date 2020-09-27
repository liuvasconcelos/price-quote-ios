//
//  Salesman.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation
import ObjectMapper

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

public class BaseResponse: Mappable {
    var status: Int?
    var result: Mappable?
    
    convenience required public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        status <- map["status"]
        result <- map["data"]

    }
}

public class SalesmanBaseResponse: BaseResponse {
    var salesman: SalesmanResponse?
    
    override public func mapping(map: Map) {
        status <- map["status"]
        salesman <- map["data"]
        super.result = salesman
    }
}

public class SalesmanResponse: Mappable {
    var id:     Int?
    var name:   String?
    var status: String?
    var phones: [PhoneResponse]?
    
    convenience required public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id     <- map["id"]
        name   <- map["name"]
        status <- map["status"]
        phones <- map["phones"]

    }
}

public class PhoneResponse: Mappable {
    var id:       Int?
    var number:   String?
    var whatsapp: Bool?
    
    convenience required public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id       <- map["id"]
        number   <- map["number"]
        whatsapp <- map["whatsapp"]

    }
}
