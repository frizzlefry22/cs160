//
//  User.swift
//  pVault
//
//  Created by Arjay Nguyen on 11/29/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

class User{
    
    private var userID: String?
    private var email: String?
    private var password: String?
    private var PIN: String?
    private var secQA: [String: String]?
    
    //full init
    init(userID: String, email: String, password: String, PIN: String, secQA: [String:String]){
        
        self.userID = userID
        self.email = email
        self.password = password
        self.PIN = PIN
        self.secQA = secQA
    }
    
    //empty user init
    init(){
        userID = ""
        email = ""
        password = ""
        PIN = ""
        secQA = ["":""]
    }
    
    
    //setters
    func setUserID(userID: String){self.userID = userID}
    func setEmail(email: String){self.email = email}
    func setPassword(password: String){self.password = password}
    func setPIN(PIN: String){self.PIN = PIN}
    func setSecQA(secQA: [String: String]){self.secQA = secQA}
    
    //getters
    func getUserID()->String{return self.userID!}
    func getEmail()->String{return self.email!}
    func getPassword()->String{return self.password!}
    func getPIN()->String{return self.PIN!}
    func getSecQA()->[String:String]{return self.secQA!}
    
    func copy()->User{
        return User(userID: userID!, email: email!, password: password!, PIN: PIN!, secQA: secQA!)
    }
    
}