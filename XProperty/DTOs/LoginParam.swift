//
//  LoginParam.swift
//  XProperty
//
//  Created by Omara on 22.12.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginParam: Mappable {
    
    init(email: String, password:String, deviceToken: String) {
        self.email = email
        self.password = password
        self.deviceToken = deviceToken
    }
    
    required init?(map: Map) {
        if let email = map["email"].currentValue as? String,
            let password = map["password"].currentValue as? String,
            let deviceToken = map["device_token"].currentValue as? String {
            self.email = email
            self.password = password
            self.deviceToken = deviceToken
        } else {
            return nil
        }
    }
    
    func mapping(map: Map) {
        email <- map["email"]
        password <- map["password"]
        deviceToken <- map["device_token"]
    }
    
    var email: String
    var password: String
    var deviceToken: String
    
}

