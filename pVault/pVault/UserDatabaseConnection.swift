//
//  UserDatabaseConnection.swift
//  pVault
//
//  Created by Arjay Nguyen on 11/21/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

public class UserDatabaseConnection: DBConnectionProtocol{
    
    
    
    //Have to do this since class var is not implemneted by Apple
    struct AlertDelStuct {
        static var alertDelegate : Alertable!
    }
    
    /*  create
    
        Intent: Receives a PFObject of a User object ready to be saved. Saves
        Param: pfObj: PFObject - PFObject ready to saved, should contain all User fields necessary
        Return: none
    */
    class func create(pfObj: PFObject, obj: AnyObject)->String{
        
        //save pfObj in background, will use callback block to handle success/fail of save
        var succeeded = pfObj.save()
        var objectID = ""
        if(succeeded){
            println("User created")
            objectID = pfObj.objectId
            AlertDelStuct.alertDelegate.AlertUser("Success")
        }
            //fail block
        else{
            println("User not created")
            AlertDelStuct.alertDelegate.AlertUser("Fail")
        }
        
        return objectID
    }
    
    /* create function called by outside classes*/
    class func createUser(user: User)->User{
        
        
        var userObj = PFObject(className: "User")
        userObj["userID"] = user.getUserID()
        userObj["email"] = user.getEmail()
        userObj["password"] = user.getPassword()
        userObj["PIN"] = user.getPIN()
        userObj["secAnswers"] = user.getSecQA()
        
        user.setUserID(create(userObj, obj: ""))
        
        return user
    }
    
    /*  edit
    
        Intent: Edit a User item in the database, prints success/fail state
                Allowed edits: PIN, secQA, password
        Param:  previous: User, user object with the previous values
                updated : User, user object with updated values, if a
                          value is to stay the same, it contains same values.
        Return:
    */
    class func edit(previous: AnyObject, updated: AnyObject){
        var newUser = updated as User
        var prevUser = previous as User
        
        var query = PFQuery(className: "User")
        query.whereKey("email", equalTo:prevUser.getEmail())
        
        query.getFirstObjectInBackgroundWithBlock{
            (PFObject object, error: NSError!) -> Void in
            
            //no error connecting to db
            if (error == nil){
                //object found
                if(object != nil){
                    
                    object["PIN"] = newUser.getPIN()
                    object["password"] = newUser.getPassword()
                    object.saveInBackgroundWithBlock({(succeeded: Bool!, error: NSError!) -> Void in
                        //success block
                        if(succeeded!){
                            println("File Saved")
                            AlertDelStuct.alertDelegate.AlertUser("Succes")
                        }
                            //fail block
                        else{
                            AlertDelStuct.alertDelegate.AlertUser("File Not Saved to the DB")
                            println("File not saved, will be saved when connection to DB is establed")
                        }
                    })
                    
                }
            }
            //error
            else{
                
            }
        }
    }
    
    /*  delete
    
        Intent
        Param:
        Return:
    */
    class func delete(query: PFQuery){
        
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
                        object.deleteInBackgroundWithBlock({(succeeded: Bool!, error: NSError!) -> Void in
                            //success block
                            if(succeeded!){
                                println("File Deleted")
                            }
                                //fail block
                            else{
                                println("File not deleted, will be saved when connection to DB is establed")
                            }
                        })
                    }
                }
            }
                //error
            else{
                
            }
        }
    }
    
    /*  read
    
        Intent:
        Param:
        Return:
    */
    class func read(query: PFQuery)->AnyObject{
        var result = query.getFirstObject()
        var user = User()
        
        //if user found, add fields
        if(result != nil){
            
            var id = result.objectId as String
            var emailAd = result["email"] as String
            var pw = result["password"] as String
            var pinNum = result["PIN"] as String
            var secAnswers = result["secAnswers"] as [String: String]
            
            user.setUserID(id)
            user.setEmail(emailAd)
            user.setPassword(pw)
            user.setPIN(pinNum)
            user.setSecQA(secAnswers)
        }
    
        return user
    }
    
    /*  getUserByEmail
    
        Intent:
        Param:
        Return:
    */
    class func getUserByEmail(email: String)->User{
        
        var query = PFQuery(className: "User")
        query.whereKey("email", equalTo: email)
        
        return read(query) as User
    }
    
    /*  getEmails
    
        Intent: get all emails, return as string in array
        Param: none
        Return: [String] containing all registered emails in User Database
    */
    class func getEmails()->[String]{
        
        var query = PFQuery(className: "User")
        var result = query.findObjects()
        var emails = [String]()
        
        for row in result{
            emails.append(row["email"] as String)
        }
        
        return emails
    }
    
    //test method, used to create a user PFObject and returns created PFObject
    class func testCreate()-> PFObject{
        var userId = "123"
        var email = "test@email.com"
        var password = "abc"
        var pin = "1234"
        var secAnswers: [String: String] = ["ques1": "ans1", "ques2": "ans2", "ques3": "ans3"]
        
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
        query.whereKey("userID", equalTo:"125")
        
        return query
    }
    
    //get security question answers, take in email, return dictionary, will comment more later
    class func getSecQA(userEmail: String)->[String:String]{
        var query = PFQuery(className: "User")
        query.whereKey("email", equalTo: userEmail)
        
        var result = query.getFirstObject()
        
        var secQA = result["secAnswers"] as [String:String]
        
        return secQA
    }
    
    
    
    
    
}