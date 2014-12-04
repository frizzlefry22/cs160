//
//  Utils.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/24/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation


//Removes String from Array arrr
func removeString ( str : String , inout arrr : [String] ) -> String{
    
    let ind = find(arrr,str)
    return arrr.removeAtIndex(ind!)
}

//Adds String to aray arrr
func addString( str : String, inout arrr : [String] ) {
    arrr.append(str)
}