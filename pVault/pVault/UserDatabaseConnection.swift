//
//  UserDatabaseConnection.swift
//  pVault
//
//  Created by Arjay Nguyen on 11/21/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

class UserDatabaseConnection: DBConnectionProtocol{
    
    init(){
        
    }
    
    /*
        Intent: Receives a PFObject of a User object ready to be saved. Saves
        Param: pfObj: PFObject - PFObject ready to saved, should contain all User fields necessary
        Return: none
    */
    func create(var pfObj: PFObject){
        
        //save pfObj in background, will use callback block to handle success/fail of save
        pfObj.saveInBackgroundWithBlock({(succeeded: Bool!, error: NSError!) -> Void in
            //success block
            if(succeeded!){
                println("File Saved")
            }
            //fail block
            else{
                println("File not saved, will be saved when connection to DB is establed")
            }
        })
    }
    
    /*
        Intent
        Param:
        Return:
    */
    func edit(){
        
    }
    
    /*
        Intent
        Param:
        Return:
    */
    func delete(){
        
    }
    
    /*
        Intent
        Param:
        Return:
    */
    func read(){
        
    }
    
    //test method, used to create a user PFObject and returns created PFObject
    func testCreate()-> PFObject{
        var userId = "123"
        var email = "test@email.com"
        var password = "abc"
        var pin = 1234
        var secAnswers: [String] = ["ans1", "ans2", "ans3"]
        
        var userObj = PFObject(className: "User")
        userObj["userID"] = userId
        userObj["email"] = email
        userObj["password"] = password
        userObj["PIN"] = pin
        userObj["secAnswers"] = secAnswers
        
        return userObj
    }
    
    
}