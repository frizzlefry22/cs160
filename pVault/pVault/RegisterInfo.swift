//
//  RegisterInfo.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/24/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

struct RegisterInfo {
    
    //
    static var email = ""
    
    //
    static var passWord = ""
    
    //
    static var pinCode  = "-1"
    
    //
    static var questions  = [String]()
    
    //
    static var answers = [String]()
    
    //Maybed create User here ?
    static func createUser(){
        
        //create dictionary from questions, answers
        var secQA = [String:String]()
        for var index = 0; index < questions.count; ++index {
            secQA[questions[index]] = answers[index]
        }
        
        //create user
        var newUser = User(userID: "", email: email as String, password: passWord, PIN: pinCode as String, secQA: secQA)
        
        //check if connected to internet/3g
        if(Reachability.isConnectedToNetwork()){
            
            //if connected, create user, save to db and locally
            LoggedInuser = UserDatabaseConnection.createUser(newUser)
            
            LocalFileManager.createUserDirectory(LoggedInuser.getEmail())
            LocalFileManager.addUser(LoggedInuser, temp: false)
            
            println("Debug")
        }else{
            //else, create user, save locally under unsynced files directory
            LoggedInuser = newUser.copy()
            
            LocalFileManager.createUserDirectory(LoggedInuser.getEmail())
            LocalFileManager.addUser(LoggedInuser, temp: true)
        }
    }
    
}