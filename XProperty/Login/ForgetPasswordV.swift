//
//  ForgetPasswordV.swift
//  XProperty
//
//  Created by Omara on 26.11.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit

class ForgetPasswordV: UIView {
    
    var dismissPopOverHandler: (() -> Void)!

    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismissPopOverHandler()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
