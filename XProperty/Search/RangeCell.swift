//
//  RangeCell.swift
//  XProperty
//
//  Created by Omara on 02.12.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit
import BMASliders

class RangeCell: UITableViewCell, CommonSearch {

    @IBOutlet weak var searchkeyL: UILabel!
    @IBOutlet weak var sliderV: BMASlider!
    @IBOutlet weak var sliderValueL: UILabel!
    
    func setup(withSearchObject searchObject: SearchObject) {
        searchkeyL.text = searchObject.searchKey
        sliderV.maximumValue = searchObject.rangeMaxValue ?? 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sliderValueL.text = "\(sliderV.currentValue)"
        sliderV.style = CustomBMASliderStyling()
        
        sliderV.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    
    @objc private func sliderValueChanged() {
        sliderValueL.text = "\(sliderV.currentValue)"
    }

}
