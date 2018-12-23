//
//  Extensions.swift
//  XProperty
//
//  Created by Omara on 02.12.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

extension UIImage {
    class func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        ctx.setFillColor(color.cgColor)
        ctx.fillEllipse(in: rect)
        
        ctx.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
}

@IBDesignable
extension UIView
{
    
    @IBInspectable
    public var maskedCornerTop: Bool {
        set {
            guard newValue else {
                self.layer.maskedCorners.remove(.layerMinXMinYCorner)
                self.layer.maskedCorners.remove(.layerMaxXMinYCorner)
                return
            }
            self.layer.maskedCorners = .layerMinXMinYCorner
            self.layer.maskedCorners.insert(.layerMaxXMinYCorner)
        }
        get {
            return self.layer.maskedCorners.contains(.layerMinXMinYCorner)
            && self.layer.maskedCorners.contains(.layerMaxXMinYCorner)
        }
    }
    
    @IBInspectable
    public var maskedCornerBottom: Bool {
        set {
            guard newValue else {
                self.layer.maskedCorners.remove(.layerMinXMaxYCorner)
                self.layer.maskedCorners.remove(.layerMaxXMaxYCorner)
                return
            }
            self.layer.maskedCorners = .layerMinXMaxYCorner
            self.layer.maskedCorners.insert(.layerMaxXMaxYCorner)
        }
        get {
            return self.layer.maskedCorners.contains(.layerMinXMaxYCorner)
                && self.layer.maskedCorners.contains(.layerMaxXMaxYCorner)
        }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat
    {
        set (radius) {
            self.layer.cornerRadius = radius
            //self.layer.masksToBounds = radius > 0
        }
        
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat
    {
        set (borderWidth) {
            self.layer.borderWidth = borderWidth
        }
        
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable
    public var borderColor:UIColor?
    {
        set (color) {
            self.layer.borderColor = color?.cgColor
        }
        
        get {
            if let color = self.layer.borderColor
            {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
    
    @IBInspectable
    public var isOval: Bool
    {
        set {
            if newValue {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
        
        get {
            return self.layer.cornerRadius == self.frame.height / 2
        }
    }
    
    @IBInspectable
    public var hasShadow: Bool {
        set {
            self.layer.applySketchShadow(x: 0, y: 2, blur: 4, spread: 0)
        }
        get {
            return false
        }
    }
}



extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

@IBDesignable
extension UILabel {
    
    @IBInspectable
    var isUnderLined: Bool {
        get {
            return false
        }
        set {
            self.attributedText = NSAttributedString(string: self.text!, attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue])
        }
    }
}

@IBDesignable
extension UIButton {
    
    @IBInspectable
    var isUnderLined: Bool {
        get {
            return false
        }
        set {
            guard self.titleLabel?.text != nil else { return }
            self.titleLabel?.attributedText = NSAttributedString(string: self.titleLabel!.text!, attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue])
        }
    }
}
