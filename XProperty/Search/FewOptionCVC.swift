//
//  FewOptionCVC.swift
//  XProperty
//
//  Created by Omara on 02.12.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit

class FewOptionCVC: UICollectionViewCell {
    
    @IBOutlet weak var selectionFrame: UIView!
    @IBOutlet weak var optionTextL: UILabel!
    
   
    
        func setup(withOption option: String, isSelected: Bool) {
        optionTextL.text = option
        selectionFrame.isHidden = !isSelected
    }
}
