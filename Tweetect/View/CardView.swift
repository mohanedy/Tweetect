//
//  CardView.swift
//  Flowerly
//
//  Created by Mohaned Yossry on 5/1/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {
     var cornerRadius : CGFloat = 10
    var shadowOfSetWidth : CGFloat = 0
    var shadowOfSetHeight : CGFloat = 5
    
    var shadowColor : UIColor = UIColor.gray
    var shadowOpacity : CGFloat = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.shadowPath = shadowPath.cgPath
        
        layer.shadowOpacity = Float(shadowOpacity)
        
    }
}
