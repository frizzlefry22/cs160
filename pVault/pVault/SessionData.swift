//
//  SessionData.swift
//  pVault
//
//  Holds all data used during current session(i.e. User, Documents, etc)
//
//  Created by Arjay Nguyen on 11/29/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

var test = [String : String]()
var docList:[(objectID: String, docName: String, docType: String)] = []

var LoggedInuser = User(userID: "test", email: "test@example.com", password: "pass!1", PIN: "1234", secQA: test)

//Need to get rid of 
