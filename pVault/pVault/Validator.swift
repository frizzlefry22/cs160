//
//  Validator.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/18/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation



let FAKEEMAIL = "arjaythegreat@gmail.com"


/*
checkPIN(String) : Boolean
checkPassword(String): Boolean
matchedPasswords(): Boolean
matchedPIN(): Boolean
checkCredentials() : Boolean
*/

struct Validator {
    
    
    static let 💩 = false
    
    /* From Functional Requirement
    3.2.LV.3.FR.3
    The password must consist of numbers, letters, and special characters and must be at least 6 characters long and at most 25 characters long.
    */
    static func passwordIsValid( pass : String ) -> Bool {
        var length = countElements(pass)
        var validLenth  = (length >= 6) && (length < 25)
        return validLenth && isValidPassword(pass)
    }
    
    
    /*
    This will use a regex to check for atleast 1 lowercase letter, number and special character
    */
    static func isValidPassword( pass  : String ) -> Bool {
        let passRegex = NSRegularExpression(pattern: "(?=.*[a-z])(?=.*[1-9])(?=.*[!@#$%^&*]).+", options: nil, error : nil)!
        if let valid =  passRegex.firstMatchInString(pass, options : nil, range: NSRange(location: 0, length : pass.utf16Count))
        {
            return true
        }
        return false
    }
    
    
    static func checkCredentials( email : String, pas : String ) -> Bool {
        return false
    }
    
    //Just checks for an @
    static func emailValid ( em : String ) -> Bool{
        
        var hasAt = em.rangeOfString("@") != nil
        return hasAt
    }
    
    /*
    Function to check if two passwords are equal
    */
    static func matches( s1 : String , s2 : String) -> Bool {
        return s1 == s2
    }
    
    static func checkPassword ( pas : String ) -> Bool {
        return 💩
    }
    
    //curently a PIN must be 4 characters in length
    static func validPin( pin : String ) -> Bool {
        return (countElements(pin) == 4)
    }
    
    //Made this static so it is called once then the data is cached
    static var emails : [String]!
    
    /*
    Function to check if email already exists
    @return true if email exists
    */
    static func emailExists ( em : String )-> Bool {
        
        if (emails == nil) {
            emails = UserDatabaseConnection.getEmails()
        }
        
        //var emails = UserDatabaseConnection.getEmails()
        
        for email in emails{
            if(em == email){
                return true
            }
        }
        return false
    }
    
}







