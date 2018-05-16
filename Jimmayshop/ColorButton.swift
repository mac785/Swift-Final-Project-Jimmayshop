//
//  ColorButton.swift
//  Jimmayshop
//
//  Created by Jamie Moseley on 5/3/17.
//  Copyright © 2017 Jamie Moseley. All rights reserved.
//

import UIKit
@IBDesignable
class ColorButton: UIButton {

    @IBInspectable var buttonColor:UIColor = UIColor.purple
    @IBInspectable var buttonNumber:Int = 0
    var colorList:[UIColor] = [UIColor.black,UIColor.blue,UIColor.red,UIColor.yellow,UIColor.white,UIColor.clear]
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let buttonPath = UIBezierPath(rect: rect)
        buttonColor = colorList[buttonNumber]
        buttonPath.lineWidth = 2
        buttonColor.setFill()
        buttonPath.fill()
        UIColor.black.setStroke()
        buttonPath.stroke()
    }
    
    
 

}
