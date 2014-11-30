//
//  ViewController.swift
//  Taking Photos with the Camera
//
//  Created by Vandad Nahavandipoor on 7/10/14.
//  Copyright (c) 2014 Pixolity Ltd. All rights reserved.
//
//  These example codes are written for O'Reilly's iOS 8 Swift Programming Cookbook
//  If you use these solutions in your apps, you can give attribution to
//  Vandad Nahavandipoor for his work. Feel free to visit my blog
//  at http://vandadnp.wordpress.com for daily tips and tricks in Swift
//  and Objective-C and various other programming languages.
//
//  You can purchase "iOS 8 Swift Programming Cookbook" from
//  the following URL:
//  http://shop.oreilly.com/product/0636920034254.do
//
//  If you have any questions, you can contact me directly
//  at vandad.np@gmail.com
//  Similarly, if you find an error in these sample codes, simply
//  report them to O'Reilly at the following URL:
//  http://www.oreilly.com/catalog/errata.csp?isbn=0636920034254

import UIKit
import MobileCoreServices

class DocPhotoViewController: UIViewController,
UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    /* We will use this variable to determine if the viewDidAppear:
    method of our view controller is already called or not. If not, we will
    display the camera view */
    var beenHereBefore = false
    var controller: UIImagePickerController?
    
    
    var docIMage : UIImage?
    

    @IBOutlet weak var uiSelector: UISegmentedControl!

    @IBAction func selectorChanged(sender: UISegmentedControl) {
        
        if  ( sender.selectedSegmentIndex == 0)
        {
            openCamera()
        }
        else {
            openPhotos()
            println("Get photo")
        }
    
        
    }
    
    //Opens up IOS Photo picker/ requests promission from Phone
    func openPhotos() {
        
        var picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        picker.delegate = self
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var imageDisplay: UIImageView!
    
    
    // This is called if the user Accepts the picture
    // Most of it from  Vandad Nahavandipoor
    func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!){
            
            println("Picker returned successfully")
            
            let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
            
            if let type:AnyObject = mediaType{
                
                if type is String{
                    
                    let stringType = type as String
                        
                    if stringType == kUTTypeImage as NSString as NSString{
                        
                        //Gets metedata, this was from example
                        let metadata = info[UIImagePickerControllerMediaMetadata]
                            as? NSDictionary
                        
                        //This is for getting the image from camera
                        if let theMetaData = metadata{
                            
                            let image = info[UIImagePickerControllerOriginalImage]
                                as? UIImage
                            if let theImage = image{
                                
                                imageDisplay.image = theImage
                                docIMage = theImage
                            }
                        }
                        //This is for getting hte image from photos
                        else {
                            let image = info[UIImagePickerControllerOriginalImage]
                                as? UIImage

                            if let appImage = image{
                                imageDisplay.image = appImage
                                docIMage = appImage
                            }
                        }
                    }
                    
                }
            }
            
            picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //If the User clicks Cancel
    // Vandad Nahavandipoor
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        println("Picker was cancelled")
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        //This goes goes back a scene
       // navigationController?.popViewControllerAnimated(true)
    }
    
    // Vandad Nahavandipoor
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    // Vandad Nahavandipoor
    func cameraSupportsMedia(mediaType: String,
        sourceType: UIImagePickerControllerSourceType) -> Bool{
            
            let availableMediaTypes =
            UIImagePickerController.availableMediaTypesForSourceType(sourceType) as
                [String]?
            
            if let types = availableMediaTypes{
                for type in types{
                    if type == mediaType{
                        return true
                    }
                }
            }
            
            return false
    }
    
    func doesCameraSupportTakingPhotos() -> Bool{
        return cameraSupportsMedia(kUTTypeImage as NSString, sourceType: .Camera)
    }
    
    
    func showDecoded() {
        
        
        let decodedData = NSData(base64EncodedString: Encryptor.base64String, options: NSDataBase64DecodingOptions.allZeros)
    
        //
        var decodedImage = UIImage(data: decodedData!)
        
        //Have to Rotate the image since when it is created from Base64String it has wrong oreintation
        var rotatedImage = UIImage(CGImage: decodedImage?.CGImage, scale: 1, orientation: UIImageOrientation.Right)
    
        
        uncodeImage.image = rotatedImage
        
    }
    
    
    @IBAction func saveToBase64(sender: AnyObject) {
        
        var imageData = UIImagePNGRepresentation(docIMage)
        

        let base64String = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
        
        Encryptor.base64String = base64String
        
        //println(base64String)
        
        showDecoded()
        
    }
    
    
    
    func openCamera () {
        if isCameraAvailable() && doesCameraSupportTakingPhotos(){
            
            controller = UIImagePickerController()
            
            if let theController = controller{
                theController.sourceType = .Camera
                
                theController.mediaTypes = [kUTTypeImage as NSString]
                
                theController.allowsEditing = true
                theController.delegate = self
                
                presentViewController(theController, animated: true, completion: nil)
            }
            
        } else {
            println("Camera is not available")
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    
}

