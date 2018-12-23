//
//  introCVC.swift
//  XProperty
//
//  Created by Omara on 03.12.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit

class IntroCVC: UICollectionViewCell {
    
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var mainTextL: UILabel!
    @IBOutlet weak var describtionTextL: UILabel!
    @IBOutlet weak var pageIndicator: UIPageControl!

    func setup(withIntroObject introObject : IntroObject) {
        imageIV.image = introObject.image
        mainTextL.text = introObject.mainText
        describtionTextL.text = introObject.descriptionText
        pageIndicator.currentPage = introObject.index
    }
    
}
