//
//  Enums.swift
//  pVault
//
//  Created by Joseph ORLANDO on 12/1/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation


enum DocumentType : String {

    case CreditCard = "Credit Card"

    case License = "License"
    
    case Certificate = "Certificate"
    
    case Other = "Other"
    
    case None = "None"

    
    static let allValues = [None,CreditCard,License,Certificate]
    
}

func DocTypeFromString(str : String) -> DocumentType {
    
   for type in DocumentType.allValues{
        if (str == type.rawValue){
            return type;
        }
    }
    //Eler return None
    return DocumentType.None
}