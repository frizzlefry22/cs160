
    //  DocumentDBConnection.swift
    //  pVault
    //
    //  Created by Kevin Tran on 11/20/14.
    //  Copyright (c) 2014 Pvault2. All rights reserved.
    //
    
import Foundation

public class DocumentDBConnecion{//: DBConnectionProtocol{
    
    
    
    
    //Param takes in a PFObject
    //PFObject is saved into parse database
    //mostly done just need to get the two array and file and then test
    class func create(pfObj: PFObject){
        
        pfObj.saveInBackgroundWithBlock({(succeeded: Bool!, error: NSError!) -> Void in
            //success block
            if(succeeded!){
                println("File Saved")
            }
                //fail block
            else{
                println("File not saved, will be saved when connection to DB is establed")
            }
        })
        
    }
    
    //Param takes in a PFQuery
    //returns the results of a PFQuery
    //need to test to make sure works, easily retrive the fields once i know it works
    class func read(objectID: String) -> Document{
        //creates an empty document
        var someDoc = Document(creatorID: "")
        //querys for the document data from parse
        var query = PFQuery(className:"Document")
        var docObject = query.getObjectWithId(objectID)
        //fills in the document data
        someDoc.objectID = docObject.objectId as String
        someDoc.docID = docObject["docID"] as String
        someDoc.userID = docObject["userID"] as String
        someDoc.docName = docObject["docName"] as String
        someDoc.docType = self.getType(docObject["docType"] as Int)
        someDoc.docDiscription = docObject["docDesc"] as String
        someDoc.docField = docObject["docField"] as Dictionary
        someDoc.docImage = docObject["docImage"] as String
        
        return someDoc
    }
    
    //in progress
    //STUPID FUCNTION GOES HERE TOO I GUESS
    class func edit(query: PFQuery){
        var query = PFQuery(className:"Document")
    }
    
    //Param takes in an existing document 
    //Calls createHistoryDocument to put the current document into a new PFObject to keep in history 
    //Calls removeHistory to remove previous versions if there are more than 2 previous version
    //only allowed to change document name, description, fields, and image
    class func editSomething(currentDoc: Document, editDoc: Document) {//-> PFQuery{
        self.createHistoryDocucment(currentDoc)
        self.removeHistory(currentDoc.objectID)
        var query = PFQuery(className:"Document")
        query.getObjectInBackgroundWithId(currentDoc.objectID) {
            (document: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
            } else {
                document["docName"] = editDoc.docName
                document["docDesc"] = editDoc.docDiscription
                document["docField"] = editDoc.docField
                document["docImage"] = editDoc.docImage
                document.saveInBackgroundWithBlock({(succeeded: Bool!, error: NSError!) -> Void in
                    //success block
                    if(succeeded!){
                        println("File Saved")
                    }
                        //fail block
                    else{
                        println("File not saved, will be saved when connection to DB is establed")
                    }
                })
            }
        }
    }
    
    //Param takes in a document ID
    //this query removes a document from the database
    class func delete(objectID: String){
        var query = PFQuery(className:"Account")
        query.getObjectInBackgroundWithId(objectID) {
            (document: PFObject!, error: NSError!) -> Void in
            if error == nil {
                document.delete()
                NSLog("%@", document)
            } else {
                NSLog("%@", error)
            }
        }
        println("Deleted document")
    }
    
    
    //Param takes in a user ID
    //Return a PFQuery
    //Used to query a all documents from one user ID used to populate a list
    class func getDocumentList(userID: String) -> PFQuery{
        var query = PFQuery(className:"Document")
        query.whereKey("userID", equalTo: userID)
        return query
    }
    
    class func getSingleDocument(docID: String) -> PFQuery{
        var query = PFQuery(className:"Document")
        query.whereKey("docID", equalTo: docID)
        return query
    }
    
    
    
    //Param takes in a document
    //Return creates a pfObject with document info
    class func createDocumentPFObject(doc: Document) -> PFObject{
        var document = PFObject(className:"Document")
        
        //will be using parse object id for document object
        //document ID will be same as object id
        document["docID"] = doc.docID
        document["userID"] = doc.userID
        document["docName"] = doc.docName
        document["docType"] = doc.getDocType(doc.docType)
        document["docDesc"] = doc.docDiscription
        document["docField"] = doc.docField
        document["docImage"] = doc.docImage
        return document
    }
    
    //will be removing this
    class func createDocumentPFObject2(doc: Document) -> PFObject{
        var document = PFObject(className:"Document")
        
        //will be using parse object id for document object
        //document ID will be same as object id
        document["userID"] = doc.userID
        document["docName"] = doc.docName
        document["docType"] = doc.getDocType(doc.docType)
        document["docDesc"] = doc.docDiscription
        document["docField"] = doc.docField
        document["docImage"] = doc.docImage
        return document
    }
    //takes in a document
    //creates a copy of the document and uploads to document table 
    //this is used for history, this document would have a document id which inidicated that it's a previous version of a current document. the latest version would have the no docID but the original object id
    class func createHistoryDocucment(doc: Document){
        var document = PFObject(className:"Document")
        document["docID"] = doc.objectID
        document["userID"] = doc.userID
        document["docName"] = doc.docName
        document["docType"] = doc.getDocType(doc.docType)
        document["docDesc"] = doc.docDiscription
        document["docField"] = doc.docField
        document["docImage"] = doc.docImage
        document.saveInBackgroundWithBlock({(succeeded: Bool!, error: NSError!) -> Void in
            //success block
            if(succeeded!){
                println("File Saved")
            }
                //fail block
            else{
                println("File not saved, will be saved when connection to DB is establed")
            }
        })
    }
    
    //Param takes in an object id 
    //this method looks at the history of a doc
    //if there are more than 2 previous version, delete the excess documents
    class func removeHistory(objectID: String){
        var query = PFQuery(className:"Document")
        query.whereKey("docID", equalTo: objectID)
        query.orderByDescending("createdAt")
        var objectArray = query.findObjects()
        var count = objectArray.count
        while(count >= 3)
        {
            var index = objectArray.count-1
            objectArray[index].delete()
            objectArray.removeAtIndex(index)
            count--
        }
    }
    
    //Param takes in a user id
    //Return returns a tuple that consists of doc pbject id, doc name, and doc type
    //this func returns an array of tuples which will be used to populate the document list
    class func getDocList(userID: String) -> [(objectID: String, docName: String, docType: Int)]{//String{ //Dictionary<String, String>{
        var docList:[(objectID: String, docName: String, docType: Int)] = []
        var query = PFQuery(className:"Document")
        query.whereKey("userID", equalTo: userID)
        query.whereKey("docID", equalTo: "")

        var objectArray = query.findObjects()
        
        for object in objectArray{
            var someID = object.objectId as String
            var someName = object["docName"] as String
            var someType = object["docType"] as Int
            var tuple = (objectID: someID, docName: someName, docType: someType)
            docList += [tuple]
        }
        return docList//docDictionary
    }
    
    class func getHistory(objectID: String) -> [(objectID: String, docName: String)]
    {
        var historyList:[(objectID: String, docName: String)] = []
        var query = PFQuery(className:"Document")
        query.whereKey("docID", equalTo: objectID)
        query.orderByDescending("createdAt")
        query.limit = 2
        var objectArray = query.findObjects()
        for object in objectArray{
            var someID = object.objectId as String
            var someName = object["docName"] as String
            var tuple = (objectID: someID, docName: someName)
            historyList += [tuple]
        }
        return historyList
    }
    
    //used to test adding a ditionary to parse, parse saves it as an array
    class func testDictionary(){
        var dictionary = ["name": "Kevin", "id": 12345, "age": 100]
        var object = PFObject(className: "TestClass")
        object.addObject(dictionary, forKey: "infor")
        object.save()
    }
    
    
    //Param takes in an int which is the int for document type on parse db
    //Return returns the document type
    class func getType(anInt: Int) -> DocumentType{
        switch anInt{
        case 0:
            return .CreditCard;
        case 1:
            return .Certificate;
        case 2:
            return .License;
        case 3:
            return .Other;
        default:
            return .Other;
        }
    }
    
    class func testGetDictionary(objectID: String) -> [String:String]{
        var temp = [String:String]()
        var someDoc = Document(creatorID: "")
        var query = PFQuery(className:"Document")
        var docObject = query.getObjectWithId(objectID)
        temp = docObject["docField"] as Dictionary
        for (myKey,myValue) in temp{
            println("\(myKey) \t \(myValue)")
        }
        return temp
    }
}




