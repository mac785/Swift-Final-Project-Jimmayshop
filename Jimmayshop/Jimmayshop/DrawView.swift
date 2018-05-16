//
//  DrawView.swift
//  Jimmayshop
//
//  Created by Jamie Moseley on 5/8/17.
//  Copyright © 2017 Jamie Moseley. All rights reserved.
//

import UIKit

class DrawView: UIView {

    var myImage: UIImage?
    var stampImage: UIImage?
    var lastPoint:CGPoint = CGPoint.zero
    var colorList:[UIColor] = [UIColor.black,UIColor.blue,UIColor.red,UIColor.yellow,UIColor.white,UIColor.clear]
    var myColor:UIColor!
    var stampHeight:CGFloat = 50
    var stampWidth:CGFloat = 50
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func awakeFromNib() {
        myColor = colorList[0]
    }
    override func draw(_ rect: CGRect) {
        // Drawing code
        if (myImage == nil) || (myImage!.size.width != rect.width) || (myImage!.size.height != rect.height){
            myImage = self.makeBlankImageOf(size: rect.size)
        }
        if let img = myImage{
            img.draw(at: CGPoint.zero)
        }
    }
 
    func addImage(image:UIImage?){
        if let img = image, let myImg = myImage{
            UIGraphicsBeginImageContext(myImg.size)
            img.draw(in: CGRect(origin: CGPoint.zero, size: myImg.size))
            myImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
        }
    }
    
    func addStampImage(image:UIImage?, myLoc:CGPoint){
        if let mainImg = myImage, let stmpImg = stampImage{
            UIGraphicsBeginImageContext(mainImg.size)
            mainImg.draw(at: CGPoint.zero)
//            let box = UIBezierPath(rect: CGRect(x: myLoc.x,y:myLoc.y,width: stampWidth, height: stampHeight))
//            UIColor.red.setFill()
//            box.fill()
            stmpImg.draw(in: CGRect(x: myLoc.x-stampWidth/2, y: myLoc.y-stampHeight/2, width: stampWidth, height: stampHeight))
            myImage = UIGraphicsGetImageFromCurrentImageContext()
            
            setNeedsDisplay()
            
            UIGraphicsEndImageContext()
        }
    }
    
    func makeBlankImageOf(size: CGSize) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(size, true, 1.0)
        let bgPath = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: size))
        UIColor.white.setFill()
        UIColor.black.setStroke()
        bgPath.fill()
        bgPath.stroke()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
    
    func drawLineOnMyImage(from start: CGPoint, to destination: CGPoint, color: UIColor, width: CGFloat){
        if let img = myImage{
            UIGraphicsBeginImageContext(img.size)
            img.draw(at: CGPoint.zero)
            
            let newLine = UIBezierPath()
            newLine.move(to: start)
            newLine.addLine(to: destination)
            color.setStroke()
            newLine.lineWidth = width
            newLine.stroke()
            
            myImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            self.setNeedsDisplay()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if (myColor == colorList[5]){
                let newPoint = touch.location(in:self)
                addStampImage(image: stampImage, myLoc: newPoint)
            }
            lastPoint = touch.location(in: self)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let newPoint = touch.location(in: self)
            if (myColor != colorList[5]){
                self.drawLineOnMyImage(from: lastPoint, to:newPoint, color: myColor, width:1)
            }
            else{
//                print("Hodor")
                addStampImage(image: stampImage, myLoc: newPoint)
            }
            lastPoint = newPoint
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let newPoint = touch.location(in: self)
            self.drawLineOnMyImage(from: lastPoint, to:newPoint, color: myColor, width:1)
        }
    }
}
