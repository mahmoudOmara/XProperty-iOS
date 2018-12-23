//
//  LoginDataDTO.swift
//  Scoozme
//
//  Created by Omara on 21.09.18.
//  Copyright © 2018 AbdallahElmahlawy. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileDataDTO: Mappable {
    required init?(map: Map) {
        if let id = map["id"].currentValue as? Int,
            let name = map["name"].currentValue as? String,
            let email = map["email"].currentValue as? String,
            let mobile = map["mobile"].currentValue as? String,
            let deviceToken = map["device_token"].currentValue as? String,
            let status = map["status"].currentValue as? Bool,
            let token = map["token"].currentValue as? String {
            self.id = id
            self.name = name
            self.email = email
            self.mobile = mobile
            self.deviceToken = deviceToken
            self.status = status
            self.token = token
        } else {
            return nil
        }
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        mobile <- map[""]
        deviceToken <- map[""]
        status <- map[""]
        token <- map["token"]
    }
    
    
    var id: Int
    var name: String
    var email: String
    var mobile: String
    var deviceToken: String?
    var status: Bool
    var token: String
    
}
