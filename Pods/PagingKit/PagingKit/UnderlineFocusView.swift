//
//  UnderlineFocusView.swift
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

/// Basic style of focus view
/// - underline height
/// - underline color
public class UnderlineFocusView: UIView {
    
    /// The color of underline
    public var underlineColor = UIColor.pk.focusRed {
        didSet {
            underlineView.backgroundColor = underlineColor
        }
    }
    
    /// The color of underline
    public var underlineHeight = CGFloat(4) {
        didSet {
            heightConstraint.constant = underlineHeight
        }
    }
    
    private var heightConstraint = NSLayoutConstraint()
    private let underlineView = UIView()
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    /// initialize the focus view with line or image
    ///
    /// - Parameter image: focus image and is a line if sent as nil
    convenience public init(image: UIImage?) {
        self.init()
        
        guard let image = image else {
            setupWithLine()
            return
        }
        setupWithImage(image: image)
    }
    
    
    
    
    
    private func setupWithLine() {
        
        heightConstraint = NSLayoutConstraint(
            item: underlineView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height, multiplier: 1, constant: underlineHeight
        )
        
        addSubview(underlineView)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(heightConstraint)
        let constraints = [.bottom, .leading, .trailing].anchor(from: underlineView, to: self)
        addConstraints(constraints)
        underlineView.backgroundColor = underlineColor
    }
    
    private func setupWithImage(image: UIImage) {
        let imageView = UIImageView()
        imageView.image = image
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let ratio = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 0.33, constant: 0)
        let width = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1/10, constant: 0)
        
        let bottomCenter = [.bottom, .centerX].anchor(from: imageView, to: self)
        addConstraints( [ratio, width] + bottomCenter)
    }
}
