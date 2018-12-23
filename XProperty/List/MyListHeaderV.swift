//
//  MyListHeaderV.swift
//  XProperty
//
//  Created by Omara on 04.12.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit

class MyListHeaderV: UIView {
    @IBOutlet weak var HeaderTitle: UILabel!
    @IBOutlet weak var arrowButton: UIButton!
    
    var isOpened: Bool = true { didSet {flipArrowButton()}}
    var openCloseSection: ((Bool)->Void)!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isOpened = !isOpened
        openCloseSection(isOpened)
    }
    
    private func flipArrowButton() {
        self.arrowButton.transform = CGAffineTransform.identity
        if !isOpened {
            self.arrowButton.transform = self.arrowButton.transform.rotated(by: CGFloat.pi)
            UIView.animate(withDuration: 1.0) {
                self.arrowButton.transform = self.arrowButton.transform.rotated(by: CGFloat.pi)
            }
        }
        else {
            UIView.animate(withDuration: 1.0) {
                self.arrowButton.transform = self.arrowButton.transform.rotated(by: CGFloat.pi)
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
