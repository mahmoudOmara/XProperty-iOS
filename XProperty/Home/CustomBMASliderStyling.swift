//
//  CustomBMASliderStyling.swift
//  XProperty
//
//  Created by Omara on 02.12.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation
import BMASliders

class CustomBMASliderStyling: NSObject, BMASliderStyling {
    func unselectedLineImage() -> UIImage! {
        return UIImage(color: #colorLiteral(red: 0.2156862745, green: 0.6862745098, blue: 0.5647058824, alpha: 1), size:CGSize(width: 7, height: 7))
    }
    
    func selectedLineImage() -> UIImage! {
        return UIImage(color: #colorLiteral(red: 0.2156862745, green: 0.6862745098, blue: 0.5647058824, alpha: 0), size:CGSize(width: 7, height: 7))
    }
    
    func handlerImage() -> UIImage! {
        return UIImage.circle(diameter: 30, color: #colorLiteral(red: 0.2156862745, green: 0.6862745098, blue: 0.5647058824, alpha: 1))
    }
    
    
}
