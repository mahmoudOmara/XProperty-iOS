//
//  LoginResultDTO.swift
//  Scoozme
//
//  Created by Omara on 21.09.18.
//  Copyright © 2018 AbdallahElmahlawy. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseArray<T: BaseMappable>: Mappable {
    required init?(map: Map) {
        if let message = map["message"].currentValue as? String,
            let status = map["status"].currentValue as? Bool {
            self.message = message
            self.status = status
        } else {
            return nil
        }
    }
    
    func mapping(map: Map) {
        data <- map["data"]
        message <- map["message"]
        status <- map["status"]
    }
    
    var data: [T]?
    var status: Bool
    var message: String
}
