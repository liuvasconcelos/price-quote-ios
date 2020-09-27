//
//  APIHandler.swift
//  PriceQuoteIos
//
//  Created by Livia Vasconcelos on 27/09/20.
//  Copyright © 2020 Livia Vasconcelos. All rights reserved.
//

import Foundation
import Alamofire

class APIHandler {
    public static func handleAPIResponse<T: BaseResponse> (data: DataResponse<T>,
                                                           completion: @escaping (BaseCallback<T>) -> Void) {
        switch(data.result) {
        case .success(let response):
            switch response.status {
            case 201:
                completion(.success(response))
            case 404:
                completion(BaseCallback.failed(error: Errors.notFound))
            default:
                completion(BaseCallback.failed(error: Errors.badRequest))
            }
        case .failure(let error):
            completion(BaseCallback.failed(error: error))
        }
    }
}
