//
//  Document.swift
//  pVault
//
//  Created by Kevin Tran on 11/21/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

class Document{

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
    
    
    //what goes in these two arrays
    var docField = Dictionary<String, String>()
    
    
    var docImage: String = ""
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
    
    
    //Param takes in a DocumentType enum
    //returns the document type as an int for use in the db
    func getDocType(type: DocumentType) -> Int{
        switch type{
        case .Creditcard:
            return 0;
        case .BirthCertificate:
            return 1;
        case .DriverLicense:
            return 2;
        case .Other:
            return 3;
        }
    }
    
    //Param this takes in a document type 
    //sets the document's fields 
    //In the controller we can set the fields with
    //docField["Card Holder"] = "Joe"
    //docField.updateValue("Joe", forKey: "Card Holder")
    func setDocField(type: DocumentType){
        switch type{
        case .Creditcard:
            self.docField = ["Card Holder": "", "Credit Card Number": "", "Security Pin": "", "Expiration Date": ""]
            break
        case .BirthCertificate:
            self.docField = ["Name": "", "Date of Birth": "", "Place of Birth": "", "Parent's name": "", "Certificate Number": ""]
            break
        case .DriverLicense:
            self.docField = ["First Name": "", "Last Name": "", "Driver License Number": "", "Expiration Date": "", "Class": "", "Date of Birth": "", "Address": ""]
            break
        case .Other:
            break
        }
    }
    
    
//    func setUserID(uID: String){
//               self.userID = uID;
//    }
}