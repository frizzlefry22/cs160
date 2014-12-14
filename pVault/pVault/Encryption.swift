//
//  Encryption.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/28/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation
import MobileCoreServices

//Using code form https://gist.github.com/alskipp/016c8ba96352e5c74bf2
extension Character {
    func utf8() -> UInt8 {
        let utf8 = String(self).utf8
        return utf8[utf8.startIndex]
    }
}

//Using code form https://gist.github.com/alskipp/016c8ba96352e5c74bf2
struct Encryptor {
    
    //Can change this to the users password ? K
    let secretKey = "(:.,?P!9@PAz"
    
    func _encrypt(c:Character, key:Character) -> String {
        let byte = [c.utf8() ^ key.utf8()]
        return String(bytes: byte, encoding: NSUTF8StringEncoding)!
    }
    
    func _encrypt(message:String, key:String) -> String {
        return reduce(Zip2(message, key), "") { $0 + self._encrypt($1) }
    }
    
    func encrypt( text : String ) -> String {
        
        let encryptedText = _encrypt(text, key: secretKey)
        return encryptedText
    }
    
    func decrypt( encryptedString : String ) -> String {
        
        return _encrypt(encryptedString, key: secretKey)
        
    }
    
}