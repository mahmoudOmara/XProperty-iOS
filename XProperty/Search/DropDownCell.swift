//
//  DropDownCell.swift
//  XProperty
//
//  Created by Omara on 02.12.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell, CommonSearch {

    @IBOutlet weak var searchkeyL: UILabel!
    @IBOutlet weak var dropDownOptions: CustomDropDownMenu!
    
    func setup(withSearchObject searchObject: SearchObject) {
        searchkeyL.text = searchObject.searchKey
        dropDownOptions.items = searchObject.options
    }
}
