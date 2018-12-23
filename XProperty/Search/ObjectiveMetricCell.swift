//
//  ObjectiveMetricCell.swift
//  XProperty
//
//  Created by Omara on 02.12.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit

class ObjectiveMetricCell: UITableViewCell, CommonSearch {

    @IBOutlet weak var searchkeyL: UILabel!
    @IBOutlet weak var metricL: UILabel!
    @IBOutlet weak var unitL: UILabel!
    @IBOutlet weak var inputTF: UIStackView!
    
    func setup(withSearchObject searchObject: SearchObject) {
        searchkeyL.text = searchObject.searchKey
        metricL.text = searchObject.metric
        unitL.text = searchObject.unit
    }

}
