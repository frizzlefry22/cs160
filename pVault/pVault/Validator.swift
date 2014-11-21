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


/* From Functional Requirement
3.2.LV.3.FR.3
The password must consist of numbers, letters, and special characters and must be at least 6 characters long and at most 25 characters long.
*/
func passwordIsValid( pass : String ) -> Bool {
    
    var length = countElements(pass)
    var validLenth  = (length >= 6) && (length < 25)
    return validLenth && isValidPassword(pass)
}

/*
This will use a regex to check for atleast 1 lowercase letter, number and special character
*/
func isValidPassword( pass  : String ) -> Bool {
    let passRegex = NSRegularExpression(pattern: "(?=.*[a-z])(?=.*[1-9])(?=.*[!@#$%^&*]).+", options: nil, error : nil)!
    if let valid =  passRegex.firstMatchInString(pass, options : nil, range: NSRange(location: 0, length : pass.utf16Count))
    {
        return true
    }
    return false
}


func checkCredentials( email : String, pas : String ) -> Bool {
    return false
}

//Just checks for an @
func emailValid ( em : String ) -> Bool{

  var hasAt = em.rangeOfString("@") != nil
  var hasEnd = em.rangeOfString(".com") != nil
  return hasAt && hasEnd
}

/*
    Function to check if two passwords are equal
*/
func matches( s1 : String , s2 : String) -> Bool {
    return s1 == s2
}


func checkPassword ( pas : String ) -> Bool {
    return false
}

//curently a PIN must be 4 characters in length
func validPin( pin : String ) -> Bool {
    return (countElements(pin) == 4)
}

/*
Function to check if email already exists
@return true if email exists
*/
func emailExists ( em : String )-> Bool {
    return em == FAKEEMAIL
}





