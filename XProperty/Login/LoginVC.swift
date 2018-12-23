//
//  LoginVC.swift
//  XProperty
//
//  Created by Omara on 26.11.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit
import Popover
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var userNameTF: CustomTextField!
    @IBOutlet weak var passwordTF: CustomTextField!
    
    let options : [PopoverOption] = [.color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), .type(.down), .arrowSize(CGSize.zero), .cornerRadius(0), .showBlackOverlay(true), .blackOverlayColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.5))]
    lazy var forgetPasswordPopover = Popover(options: options, showHandler: nil, dismissHandler: nil)
    lazy var forgetPasswordV: ForgetPasswordV = {
        let x = Bundle.main.loadNibNamed("ForgetPasswordV", owner: self, options: nil)?.first as! ForgetPasswordV
        x.dismissPopOverHandler = {self.forgetPasswordPopover.dismiss()}
        return x
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    //MARK: - IB Actions
    
    @IBAction func forgetPasswordBtnClicked(_ sender: Any) {
        self.forgetPasswordPopover.showAsDialog(self.forgetPasswordV)
    }
    
    @IBAction func loginBtnClicked(_ sender: Any?) {
        var anyMissingField = false
        
        if Helper.isEmptyString(test: userNameTF.text!) {
            userNameTF.heighLight()
            anyMissingField = true
        }
        if Helper.isEmptyString(test: passwordTF.text!) {
            passwordTF.heighLight()
            anyMissingField = true
        }
        
        if anyMissingField {
            Helper.showAlert("Missing Fields", message: "Please Fill Red Fields.")
            
        } else if !Helper.isValidEmail(testStr: userNameTF.text!) {
            
            userNameTF.heighLight()
            Helper.showAlert("Invalid Email Format", message: "Please enter a valid Email.")
            
        } else if (passwordTF.text?.count)! < 6 {
            
            passwordTF.heighLight()
            Helper.showAlert("Invalid Password", message: "Password Must Be At Least 6 Characters.")
            
        } else if !Helper.connected() {
            Helper.showAlert("Connection Error", message: "Please check your internet connection.")
        } else {
            let params =  LoginParam(email: userNameTF.text!, password: passwordTF.text!, deviceToken: "device_Token").toJSON()
            
            Helper.showLoading("Logging In")
            WebService.request(urlString: Constants.baseUrl + Constants.login, method: .post, parameters: params, headers: nil, reTryCount: 2, callBack: { (res: Response<ProfileDataDTO>) in
                if res.status {
                    Helper.hideLoading(success: true)
                    self.performSegue(withIdentifier: "login", sender: nil)
                    (UIApplication.shared.delegate as! AppDelegate).currentUserProfile = res.data
                    var userInfo = res.data?.toJSON()
                    userInfo?["password"] = self.passwordTF.text
                    Helper.saveUserDetails(dict: userInfo ?? [:])
                } else {
                    Helper.hideLoading(success: false, withFailureString: res.message)
                }
            }) { (error) in
                Helper.hideLoading(success: false, withFailureString: "Failure")
                Helper.showAlert("Connection Error", message: "Please check your internet connection.")
                print(error)
            }
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTF {
            passwordTF.becomeFirstResponder()
        } else {
            loginBtnClicked(nil)
        }
        return true
    }
}
