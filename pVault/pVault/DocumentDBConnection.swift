
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
    class func read(query: PFQuery){
        
//        var query = PFQuery(className:"Document")
//        query.whereKey("docID", equalTo: docID)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) Something!.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        
        println("Readed the document")
        //let someDoc = Document(creatorID: "something")
        
        //return someDoc
    }
    
    //in progress
    //STUPID FUCNTION GOES HERE TOO I GUESS
    class func edit(query: PFQuery){
        
    }
    
    //Param takes in a document ID
    //this query removes a document from the database
    class func delete(docID: String){
        var query = PFQuery(className:"Account")
        query.getObjectInBackgroundWithId(docID) {
            (document: PFObject!, error: NSError!) -> Void in
            if error == nil {
                document.deleteInBackground()
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
        //document["docID"] = doc.docID
        document["userID"] = doc.userID
        document["docName"] = doc.docName
        document["docType"] = doc.getDocType(doc.docType)
        document["docDesc"] = doc.docDiscription
        //        account["docFieldTypes"] = nil
        //        account["docFieldValues"] = nil
        //        account["docFile"] = nil    }
        return document
    }
    
    
    class func getDocList(userID: String) -> Dictionary<String, String>{
        var docDictionary = [String: String]()
        var query = PFQuery(className:"Document")
        query.whereKey("userID", equalTo: userID)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) Something!.")
                // Do something with the found objects
                for object in objects {
                    var docID = object["objectid"] as String
                    var docName = object["docName"] as String
                    docDictionary[docID] = docName
                    NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        return docDictionary
    }
    
    //returns list by doc type
    class func searchDocByType(){
        
    }
    
//    let testDoc = Document(creatorID: "testString")
//    let dbConnection = DocumentDBConnecion()
//    
//    
//    func test(){
//        testDoc.docID = "testDocID"
//        testDoc.docName = "Testdoc"
//        testDoc.docType = DocumentType.Other
//        testDoc.docDiscription = "This is a test description"
//        
//        
//        dbConnection.create(testDoc)
//        dbConnection.read(testDoc.docID)
//        
//        XCTAssert(true, "Pass")
//    }
    
    
}




