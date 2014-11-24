
    //  DocumentDBConnection.swift
    //  pVault
    //
    //  Created by Kevin Tran on 11/20/14.
    //  Copyright (c) 2014 Pvault2. All rights reserved.
    //
    
import Foundation

public class DocumentDBConnecion{
    
    //Param takes in a PFObject
    //PFObject is saved into parse database
    //mostly done just need to get the two array and file and then test
    func create(pfObj: PFObject){
        
        pfObj.save()
        println("Document Created")
    }
    
    //Param takes in a PFQuery
    //returns the results of a PFQuery
    //need to test to make sure works, easily retrive the fields once i know it works
    func read(query: PFQuery){
        
//        var query = PFQuery(className:"Account")
//        query.whereKey("docID", equalTo: docID)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) scores.")
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
        let someDoc = Document(creatorID: "something")
        
        //return someDoc
    }
    
    //in progress
    func edit(){
        
    }
    
    //should be easy enough
    func delete(){
        
    }
    
    
    //Param takes in a user ID
    //Return a PFQuery
    //Used to query a all documents from one user ID used to populate a list
    func getDocumentList(userID: String) -> PFQuery{
        var query = PFQuery(className:"Account")
        query.whereKey("userID", equalTo: userID)
        return query
    }
    
    
    
    
    //Param takes in a document
    //creates a pfObject with document info
    func createDocumentPFObject(doc: Document) -> PFObject{
        var document = PFObject(className:"Account")
        document["docID"] = doc.docID
        document["userID"] = doc.userID
        document["docName"] = doc.docName
        document["docType"] = doc.getDocType(doc.docType)
        document["docDesciption"] = doc.docDiscription
        //        account["docFieldTypes"] = nil
        //        account["docFieldValues"] = nil
        //        account["docFile"] = nil    }
        return document
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




