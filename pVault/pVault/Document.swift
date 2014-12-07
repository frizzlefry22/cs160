//
//  Document.swift
//  pVault
//
//  Created by Kevin Tran on 11/21/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

@objc class Document{

    init(creatorID: String){
        self.userID = creatorID
    }
    
    //document ID
    var objectID = ""
    
    var _docID = ""
    
    var docID: String{
        set(setDocID){
            self._docID = setDocID
        }
        get{
            return self._docID
        }
    }
    
    //user id, person who is loged in and created document
    var _userID = ""
    var userID: String{
        set(setUID){
            self._userID = setUID
        }
        get{
            return self._userID
        }
    }
    
    //document name
    var _docName = ""
    var docName: String{
        set(setDocName){
            self._docName = setDocName
        }
        get{
            return self._docName
        }
    }
    
    //document type this is an enum
    var _docType = DocumentType.Other
    var docType: DocumentType{
        set(setDocType){
            self._docType = setDocType
        }
        get{
            return self._docType
            }
        }
    
    //document discription
    var _docDiscription = ""
    var docDiscription: String{
        set(setDocDiscription){
            self._docDiscription = setDocDiscription
        }
        get{
            return self._docDiscription
        }
    }
    
    
    //dictionary for the fields
    var docField = Dictionary<String, String>()
    
    
    var docImage: String!
    
    
    var editEnabled : Bool!
    
    
    //Param takes in a DocumentType enum
    //returns the document type as an int for use in the db
    func getDocType(type: DocumentType) -> Int{
        switch type{
        case .CreditCard:
            return 0;
        case .Certificate:
            return 1;
        case .License:
            return 2;
        case .Other:
            return 3;
        default:
            return -1
        }
        
    }
    
    //Param this takes in a document type 
    //sets the document's fields 
    //In the controller we can set the fields with
    //docField["Card Holder"] = "Joe"
    //docField.updateValue("Joe", forKey: "Card Holder")
    func setDocField(type: DocumentType){
        switch type{
        case .CreditCard:
            self.docField = ["Card Holder": "", "Credit Card Number": "", "Security Pin": "", "Expiration Date": ""]
            break
        case .Certificate:
            self.docField = ["Name": "", "Date of Birth": "", "Place of Birth": "", "Parent's name": "", "Certificate Number": ""]
            break
        case .License:
            self.docField = ["First Name": "", "Last Name": "", "Driver License Number": "", "Expiration Date": "", "Class": "", "Date of Birth": "", "Address": ""]
            break
        case .Other:
            break
        default:
            break
        }
    }
    
    func getHalves() -> (imageA: String, imageB: String){
        var str = self.docImage
        var length = countElements(str)
        var half = length/2
        var stringA = str.substringToIndex(advance(str.startIndex, half))
        var stringB = str.substringFromIndex(advance(str.startIndex,half))
        var tuple = (imageA: stringA, imageB: stringB)
        return tuple
    }
    
}