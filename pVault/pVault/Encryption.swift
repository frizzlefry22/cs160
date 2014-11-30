//
//  Encryption.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/28/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation
import MobileCoreServices

struct Encryptor {
    
    
    static var base64String = ""
    
    
    static func encrypt() {
    
    }
    
    static func decrypt() {
        
    }
    
    //decodes a base64string to an image
    static func decodeImage( str : String) -> UIImage! {
        
        let decodedData = NSData(base64EncodedString: str, options: NSDataBase64DecodingOptions.allZeros)
        
        //
        var decodedImage = UIImage(data: decodedData!)
        
        //Have to Rotate the image since when it is created from Base64String it has wrong oreintation
        var rotatedImage = UIImage(CGImage: decodedImage?.CGImage, scale: 1, orientation: UIImageOrientation.Right)
        
        //Return the new properly rotated image
        return rotatedImage
    }
    
    //function that encodes an image into a  base64string
    //@return the base64 string
    static func encodeImage( img : UIImage)  -> String {
        
        var imageData = UIImagePNGRepresentation(img)
        
        let base64 = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
       
        return base64
    }
    
}