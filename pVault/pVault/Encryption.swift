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

struct Encryptor {
    
    static func encrypt( text : String ) -> String {
        
        
        var encryptedString = ""
        
        for char in text {
            let mask  = Character(UnicodeScalar( char.utf8() ^ 7 ))
            
            encryptedString.append(mask)
        }
        
        return encryptedString
    }
    
    static func decrypt( encryptedString : String ) -> String {
        
       var decryptedString = ""
        
        for char in encryptedString {
            let mask = Character(UnicodeScalar( char.utf8()  ^ 7))
            
            
            decryptedString.append(mask)
        }
        
        return decryptedString
    }
    
}