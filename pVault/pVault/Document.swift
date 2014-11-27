//
//  Document.swift
//  pVault
//
//  Created by Kevin Tran on 11/21/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

class Document{
    
    var _docID = ""
    var docID: String{
        set(setDocID){
            self._docID=setDocID
        }
        get{
            return self._docID
        }
    }
    
    var _userID = ""
    var userID: String{
        set(setUID){
            self._userID = setUID
        }
        get{
            return self._userID
        }
    }
    
    var _docName = ""
    var docName: String{
        set(setDocName){
            self._docName = setDocName
        }
        get{
            return self._docName
        }
    }
    
    var _docType = DocumentType.Other
    var docType: DocumentType{
        set(setDocType){
            self._docType = setDocType
        }
        get{
            return self._docType
            }
        }
    
    var _docDiscription = ""
    var docDiscription: String{
        set(setDocDiscription){
            self._docDiscription = setDocDiscription
        }
        get{
            return self._docDiscription
        }
    }
    
    //what goes in these two arrays
    var docFieldTypes = ["Credit Card", "Other"]
    var docFiledValues = [String]()
    

//    var docImage: UIImage{
//        set(setUIImage){
//            self._docImage = setUIImage
//        }
//        get{
//            return self._docImage
//        }
//    }

    //docID generator?
    //takes the current user's id who is creating the document
//    init(creatorID: String){
//        userID = creatorID
//        docID = "testdocID"
//    }
    
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
    
//    func setUserID(uID: String){
//               self.userID = uID;
//    }
}