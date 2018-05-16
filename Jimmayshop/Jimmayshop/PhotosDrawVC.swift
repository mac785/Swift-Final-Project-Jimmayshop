//
//  PhotosDrawVC.swift
//  Jimmayshop
//
//  Created by Jamie Moseley on 5/8/17.
//  Copyright © 2017 Jamie Moseley. All rights reserved.
//

import UIKit

class PhotosDrawVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var primaryView:DrawView!
    var buttonMode:Int = 0
    
    @IBAction func handleAddFromLibrary(sender:UIButton){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            buttonMode = sender.tag
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func colorChanger(sender:ColorButton){
        primaryView.myColor = primaryView.colorList[sender.buttonNumber]
    }
    
//    @IBAction func clearButton(sender:ColorButton){
//        
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject:Any]!) {
        if (buttonMode == 0){
            primaryView.addImage(image: image)
            primaryView.setNeedsDisplay()
            self.dismiss(animated: true, completion: nil)
        }
        else{
            primaryView.stampImage = image
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
