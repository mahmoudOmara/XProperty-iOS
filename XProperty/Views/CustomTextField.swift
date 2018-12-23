
//
//  CustomTextField.swift
//  Scoozme
//
//  Created by Omara on 30.08.18.
//  Copyright © 2018 AbdallahElmahlawy. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    
    @IBInspectable var placeHolderColor: UIColor? {
        didSet{
            coloredPlaceHolder()
        }
    }
    @IBInspectable var rightBtnImage: UIImage?
    @IBInspectable var bottomBorderColor: UIColor?
    
    var rightButtonAction : ((UIButton) -> Void)?
    
    private var invalidInputDescribtionIndex: Int?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coloredPlaceHolder()
        accessoriesed(by: rightBtnImage)
        bottomBorder()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        coloredPlaceHolder()
        accessoriesed(by: rightBtnImage)
        bottomBorder()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 0)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rightviewWidth = bounds.height / 3
        return CGRect(x: bounds.width - bounds.height, y: (bounds.height / 2) - (rightviewWidth / 2), width: rightviewWidth, height: rightviewWidth)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 0)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 0)
    }
    func coloredPlaceHolder() {
        //        var _font = UIFont()
        //        if UIDevice.current.userInterfaceIdiom == .phone{
        //            _font = UIFont(name: "Quicksand-Bold", size: 20)!
        //        } else {
        //            _font = UIFont(name: "Quicksand-Bold", size: 40)!
        //        }
        
        guard let color = placeHolderColor  else {
            return
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font : font!])
    }
    
    func setPlaceHolder(withString str: String) {
        let color = placeHolderColor ?? UIColor.lightGray
        
        attributedPlaceholder = NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font : font!])
    }
    
    func accessoriesed(by rightAccessoryImage: UIImage?) {
        guard let image = rightAccessoryImage else {
            return
        }
        rightViewMode = UITextField.ViewMode.always
        let button = UIButton()
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(rightButtonClousre(btn:)), for: .touchUpInside)
        rightView = button
       // rightView?.translatesAutoresizingMaskIntoConstraints = false
        
//        let widthConstraint = NSLayoutConstraint(item: rightView!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: frame.height / 2)
//        let heightConstraint = NSLayoutConstraint(item: rightView!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: frame.height / 2)
//        rightView?.addConstraints([heightConstraint,widthConstraint])
    }
    
    @objc private func rightButtonClousre(btn: UIButton) {
        guard let action = rightButtonAction  else {
            return
        }
        action(btn)
    }
    
    func bottomBorder() {
        
        guard let color = bottomBorderColor else {
            return
        }
        
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        
        addSubview(lineView)
        
        let allignmentConstraintBottom = NSLayoutConstraint(item: lineView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let allignmentConstraintLeft = NSLayoutConstraint(item: lineView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let allignmentConstraintRight = NSLayoutConstraint(item: lineView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        
        let height: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 2.0 : 4.0
        let heightConstraint = NSLayoutConstraint(item: lineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        addConstraints([allignmentConstraintBottom, allignmentConstraintLeft, allignmentConstraintRight,heightConstraint])
        
    }
    
    func isEmpty() -> Bool {
        return text?.isEmpty ?? true
    }
    
    func heighLight() {
        placeHolderColor = UIColor.red
    }
}
