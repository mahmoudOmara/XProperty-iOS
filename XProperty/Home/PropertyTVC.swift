//
//  PropertyTVC.swift
//  XProperty
//
//  Created by SpellAd on 12/10/18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit

class PropertyTVC: UITableViewCell {

    @IBOutlet weak var typeLBKGV: UIView!
    @IBOutlet weak var typeL: UILabel!
    @IBOutlet weak var numberOfBedRoomsL: UILabel!
    @IBOutlet weak var areaL: UILabel!
    @IBOutlet weak var priceL: UILabel!
    
    
    
    func setup(withProperty property: Property)  {
        numberOfBedRoomsL.text = property.BDNum
        typeL.text = property.tyoe
        areaL.text = property.area
        priceL.text = property.price
    }
    

}
