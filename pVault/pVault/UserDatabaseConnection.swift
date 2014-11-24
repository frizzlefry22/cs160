//
//  UserDatabaseConnection.swift
//  pVault
//
//  Created by Arjay Nguyen on 11/21/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

class UserDatabaseConnection: DBConnectionProtocol{
    
    
    
    /*
        Intent: Receives a PFObject of a User object ready to be saved. Saves
        Param: pfObj: PFObject - PFObject ready to saved, should contain all User fields necessary
        Return: none
    */
    class func create(pfObj: PFObject){
        
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
        Intent: Edit a User item in the database, prints success/fail state
        Param:  query: PFQuery - query used to find user

        Return:
    */
    class func edit(query: PFQuery){
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error: NSError!) -> Void in
            
            //object(s) found
            if error == nil{
                
                for object in objects{
                    //process object
                }
            }
            //object(s) not found
            else{
                
            }
        }
    }
    
    /*
        Intent
        Param:
        Return:
    */
    class func delete(){
        
    }
    
    /*
        Intent:
        Param:
        Return:
    */
    class func read(query: PFQuery){
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error: NSError!) -> Void in
            
            //object(s) found
            if error == nil{
                
                //check if empty
                if (objects.isEmpty){
                    println("nothing found")
                }
                //if found, process objects, should only be one
                else{
                    for object in objects{
                        //process object
                    
                        var id = object["userID"] as String
                        println(id)
                    }
                }
            }
                //error
            else{
                
            }
        }
    }
    
    //test method, used to create a user PFObject and returns created PFObject
    class func testCreate()-> PFObject{
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
    
    //test method, used to create a PFQuery, returns PFQuery
    class func createTestQuery()->PFQuery{
        var query = PFQuery(className: "User")
        query.whereKey("userID", equalTo:"123")
        
        return query
    }
    
    
}