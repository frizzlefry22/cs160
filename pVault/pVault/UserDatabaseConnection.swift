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
        var succeeded = pfObj.save()
        
        if(succeeded){
            println("File Saved")
        }
            //fail block
        else{
            println("File not saved, will be saved when connection to DB is establed")
        }
    }
    
    /*
        Intent: Edit a User item in the database, prints success/fail state
        Param:  query: PFQuery - query used to find user

        Return:
    */
    class func edit(query: PFQuery, editCols: [String: String]){
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
    class func delete(query: PFQuery){
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error: NSError!) -> Void in
            //kevin sucks
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
    
    /*
        Intent:
        Param:
        Return:
    */
    class func read(query: PFQuery)->[[String:String]]{
        var array = [[String:String]]()
        var row = [String:String]()
        
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
                    
                    //check if more than one user
                    if (objects.count == 1){
                        var ans: [String]
                        
                        var object:AnyObject = objects[0]
                        row["userID"] = object["userID"] as String!
                        row["email"] = object["email"] as String!
                        row["password"] = object["password"] as String!
                        row["PIN"] = object["PIN"] as String!
                        
                        ans = object["secAnswers"] as Array
                        
                        var i = 1
                        for i = 1; i <= ans.count; i++ {
                            var rowInc = "secAns" + String(i)
                            row[rowInc] = ans[i-1]
                        }
                        
                        
                        array.append(row)
                        
                        
                    }
                    else{
                        //inform user issue, cannot find unique user
                        //print issue to console
                    }
                }
            }
            //error
            else{
                println("read user error")
            }
        }
        return array
    }
    
    class func testEdit(){
        var dict: [String: String] =  ["email": "editTest@email.com", "password": "newPW", "PIN": "4231" ]
        var query = PFQuery(className: "User")
        query.whereKey("email", equalTo:"test@email.com")
        
        
        edit(query, editCols: dict)
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
        query.whereKey("userID", equalTo:"124")
        
        return query
    }
    
    
}