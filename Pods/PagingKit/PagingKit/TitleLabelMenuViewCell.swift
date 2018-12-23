//
//  TitleLabelMenuViewCell.swift
//  PagingKit
//
//  Copyright (c) 2017 Kazuhiro Hayashi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit


/// Basic style of cell
/// - center text
/// - emphasize text to focus color
public class TitleLabelMenuViewCell: PagingMenuViewCell {
    
    ///  The text color when selecred
    public var focusColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {
        didSet {
            if isSelected {
                titleLabel.textColor = focusColor
            }
        }
    }
    
    /// The normal text color.
    public var normalColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 0.8) {
        didSet {
            if !isSelected {
                titleLabel.textColor = normalColor
            }
        }
    }
    
    public var focusBackGroundColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 0.8) {
        didSet {
            if isSelected {
                backgroundColor = focusBackGroundColor
            }
        }
    }
    
    public var normalBackGroundColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 0.8) {
        didSet {
            if !isSelected {
                backgroundColor = normalBackGroundColor
            }
        }
    }
    
    
    public let titleLabel = { () -> UILabel in
        let label = UILabel()
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            label.font = UIFont(name: "Quicksand-Bold", size: 16)
        } else {
            label.font = UIFont(name: "Quicksand-Bold", size: 24)
        }
        label.textAlignment = .center
        return label
    }()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.clear
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            anchorLabel(from: titleLabel, to: self, attribute: .top),
            anchorLabel(from: titleLabel, to: self, attribute: .leading),
            anchorLabel(from: self, to: titleLabel, attribute: .trailing),
            anchorLabel(from: self, to: titleLabel, attribute: .bottom)
            ])
    }
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = focusColor
                backgroundColor = focusBackGroundColor
            } else {
                titleLabel.textColor = normalColor
                backgroundColor = normalBackGroundColor
            }
        }
    }
    
    
    /// syntax sugar of NSLayoutConstraint for titleLabel (Because this library supports iOS8, it cannnot use NSLayoutAnchor.)
    private func anchorLabel(from fromItem: Any, to toItem: Any, attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: fromItem,
            attribute: attribute,
            relatedBy: .equal,
            toItem: toItem,
            attribute: attribute,
            multiplier: 1,
            constant: 8
        )
    }
}

