//
//  Document.swift
//  pVault
//
//  Created by Kevin Tran on 11/21/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

class Document{
    
    
    var docID: String{
        set(setDocID){
            self.docID=setDocID
        }
        get{
            return self.docID
        }
    }
    
    var userID: String{
        set(setUserID){
            self.userID = setUserID
        }
        get{
            return self.userID
        }
    }
    
    var docName: String{
        set(setDocName){
            self.docName = setDocName
        }
        get{
            return self.docName
        }
    }
    
    var docType: DocumentType{
        set(setDocType){
            self.docType = setDocType
        }
        get{
            return self.docType
            }
        }
    
    
    var docDiscription: String{
        set(setDocDiscription){
            self.docDiscription = setDocDiscription
        }
        get{
            return self.docDiscription
        }
    }
    
    //what goes in these two arrays
    var docFieldTypes = ["Credit Card", "Other"]
    var docFiledValues = [String]()
    
    var docImage: UIImage{
        set(setUIImage){
            self.docImage = setUIImage
        }
        get{
            return self.docImage
        }
    }

    //docID generator?
    //takes the current user's id who is creating the document
    init(creatorID: String){
        self.userID = creatorID
        docID = "testdocID"
    }
    
    //Param takes in a DocumentType enum
    //returns the document type as an int for use in the db
    func getDocType(type: DocumentType) -> Int{
        switch type{
        case .Creditcard:
            return 0;
        case .Other:
            return 1;
        }
    }
}