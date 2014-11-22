//
//  DatabaseConnection.swift
//  pVault
//
//  Created by Arjay Nguyen on 11/19/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

protocol DBConnectionProtocol{
    
    func create(var pfObj: PFObject)
    func read()
    func edit()
    func delete()
    
}