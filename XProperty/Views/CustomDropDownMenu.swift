
//
//  CustomDropDownMenu.swift
//  Scoozme
//
//  Created by Omara on 25.09.18.
//  Copyright © 2018 AbdallahElmahlawy. All rights reserved.
//

import UIKit

class CustomDropDownMenu: KPDropMenu {
    
    @IBOutlet weak var titleL: UILabel!{
        didSet {
            defaultTitle = titleL.text
            titleL.textColor = defaultTitleColor
        }
    }
    
    private var defaultTitle: String!
    private lazy var defaultTitleColor = titleL.textColor
    
    var selectedItem: String? {
        get{
            return titleL.text == defaultTitle ? nil : titleL.text
        }
        set{
            titleL.text = newValue
        }
    }
    
    var selectedItemId: Int? {
        let index = (items as? [String])?.index(where: { (item) -> Bool in
            item == selectedItem
        })
        return index == nil ? nil : (itemsIDs as? [Int])?[index!]
    }
    
    
    override func awakeFromNib() {
        self.delegate = self
    }
    
    func heighlight() {
        titleL.textColor = UIColor.red
    }
    
    func invHeilight() {
        titleL.textColor = defaultTitleColor
    }
    
    //    func setup(items: [CategoryDTO]) {
    //        self.items = items.map({ (item) -> String in
    //            return item.name
    //        })
    //        self.itemsIDs = items.map({ (item) -> Int in
    //            return item.id
    //        })
    //
    //    }
    //
    //    func setup(items: [LanguageDTO]) {
    //        self.items = items.map({ (item) -> String in
    //            return item.name
    //        })
    //        self.itemsIDs = items.map({ (item) -> Int in
    //            return item.id
    //        })
    //    }
    //
    //    func setup(items: [NationalityDTO]) {
    //        self.items = items.map({ (item) -> String in
    //            return item.countryName
    //        })
    //        self.itemsIDs = items.map({ (item) -> Int in
    //            return item.id
    //        })
    //    }
    //
    //    func setup(items: [CareerDTO]) {
    //        self.items = items.map({ (item) -> String in
    //            return item.name
    //        })
    //        self.itemsIDs = items.map({ (item) -> Int in
    //            return item.id
    //        })
    //    }
    
}

extension CustomDropDownMenu: KPDropMenuDelegate {
    // MARK: - DropDownList
    func didSelectItem(_ dropMenu: KPDropMenu!, at atIndex: Int32) {
        invHeilight()
        selectedItem = self.items?[Int(atIndex)] as? String
        
    }
}

