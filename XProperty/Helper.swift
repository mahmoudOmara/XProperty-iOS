//
//  Helper.swift
//  Mashgaly
//
//  Created by haitham tory on 7/5/17.
//  Copyright © 2017 haitham tory. All rights reserved.
//

import UIKit
import RappleProgressHUD
import Alamofire
import AlamofireImage
import CoreData
import Reachability

class Helper: NSObject {
    
    
    static let sharedDateFormatter = DateFormatter()
    

    class func connected() -> Bool {
        let reachability = Reachability()!
        return reachability.connection == .none ? false : true
    }
    
    class func combineTwoStringsWithTwoColors(firstString:String, with color1:UIColor, secondString:String, with color2:UIColor,withFont font: UIFont) -> NSMutableAttributedString{
        let s1 = NSAttributedString(string: firstString, attributes: [NSAttributedString.Key.foregroundColor : color1, NSAttributedString.Key.font : font])
        let s2 = NSAttributedString(string: secondString, attributes: [NSAttributedString.Key.foregroundColor : color2, NSAttributedString.Key.font : font])
        let result = NSMutableAttributedString()
        result.append(s1)
        result.append(s2)
        return result
    }
    
    
    
    class func showConnectionErrorRetryAlert(closure: @escaping ()->Void) {
        
        let alert = UIAlertController(title: "Connection Error", message: "Check your internet connection.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "retry", style: .default, handler: { (action) in
            closure()
        }) )
        let root = UIApplication.shared.keyWindow?.rootViewController
        
        root?.present(alert, animated: true, completion: nil)
    }
    
    class func showLocationErrorRetryAlert(closure: @escaping ()->Void) {
        
        let alert = UIAlertController(title: "Location Error", message: "Check that you allow scoozmi to get your location.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "retry", style: .default, handler: { (action) in
            closure()
        }) )
        let root = UIApplication.shared.keyWindow?.rootViewController
        root?.present(alert, animated: true, completion: nil)
    }
    
    class func showAlert(_ title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertVC.addAction(ok)
        let root = UIApplication.shared.keyWindow?.rootViewController
        root?.present(alertVC, animated: true, completion: nil)
    }
    
    
    class func showLoading(_ title: String) {
        
        let attributes = RappleActivityIndicatorView.attribute(style: .apple, tintColor: .white, screenBG: UIColor(white: 0.0, alpha: 0.2), progressBG: UIColor(white: 0.0, alpha: 0.5), progressBarBG: .red, progreeBarFill: .white, thickness: 4)
        
        RappleActivityIndicatorView.startAnimatingWithLabel(title, attributes: attributes)
    }
    
    class func hideLoading(success: Bool, withFailureString: String = "") {
        
        if success {
            RappleActivityIndicatorView.stopAnimation()
        } else {
            RappleActivityIndicatorView.stopAnimation(completionIndicator: .failed, completionLabel: withFailureString, completionTimeout: 1.0)
        }
    }
    
    
    class func isEmptyString(test: String) -> Bool {
        
        if test == "" {
            
            return true
        }
        
        return false
    }
    
    
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func saveUserDetails(dict: [String: Any]) {
        
        let userDefault = UserDefaults.standard
        var user = [String: Any]()
        
        if let id = dict["id"] as? NSNumber {
            
            user["id"] = id
        }
        
        if let name = dict["name"] as? String {
            
            user["name"] = name
        }
        
        if let email = dict["email"] as? String {
            
            user["email"] = email
        }
        
        if let longitude = dict["longitude"] as? Double {
            
            user["longitude"] = longitude
        }
        
        if let latitude = dict["latitude"] as? Double {
            
            user["latitude"] = latitude
        }
        
        if let imageUrl = dict["avatar"] as? String {
            
            user["avatar"] = imageUrl
        }
        
        if let bussinessCard = dict["business_card"] as? String {
            
            user["business_card"] = bussinessCard
        }
        
        if let eventsCount = dict["events_count"] as? Int {
            
            user["events_count"] = eventsCount
        }
        
        if let contactsCount = dict["contacts_count"] as? Int {
            
            user["contacts_count"] = contactsCount
        }
        
        if let token = dict["token"] as? String {
            
            user["token"] = token
        }
        
        if let language = dict["language"] as? [String : Any] {
            user["language"] = language
        }
        
        if let career = dict["career"] as? [String : Any] {
            user["career"] = career
        }
        
        if let nationality = dict["nationality"] as? [String : Any] {
            user["nationality"] = nationality
        }
        
        if let category = dict["category"] as? [String : Any] {
            user["category"] = category
        }
        
        if let password = dict["password"] as? String {
            
            user["password"] = password
        }
        
        
        
        userDefault.setValue(user, forKey: "user")
        userDefault.synchronize()
    }
    
    class func logOutUser() {
        
        let userDefault = UserDefaults.standard
        
        userDefault.removeObject(forKey: "user")
    }
    
    class func getUserDetails() -> [String: Any] {
        
        let userDefault = UserDefaults.standard
        var user = [String: Any]()
        
        if userDefault.value(forKey: "user") != nil {
            
            user = userDefault.value(forKey: "user") as! [String: Any]
        }
        
        return user
    }
    
    class func getUserName() -> String?{
        
        let user = getUserDetails()
        if let name = user["name"] as? String {
            return name
        }
        return nil
    }
    
    class func getUserAvatar() -> String?{
        
        let user = getUserDetails()
        if let avatar = user["avatar"] as? String {
            return avatar
        }
        return nil
    }
    
    class func getUserToken() -> String?{
        
        let user = getUserDetails()
        if let token = user["token"] as? String {
            return token
        }
        return nil
    }
    class func getUserId() -> NSNumber? {
        
        let user = getUserDetails()
        if let userID = user["id"] as? NSNumber {
            return userID
        }
        return nil
    }
    
    
    class func dateFrom(string: String) -> Date {
        
        sharedDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Server time zone
        return sharedDateFormatter.date(from: string) ?? Date()
    }
    
    
    
    
    
    
}

