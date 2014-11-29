
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
    
    //Param takes in an existing document 
    //Return returns a parse query to upload new document
    class func editOverExisting(doc: Document) -> PFQuery{
        
    }
    
    //Param takes in a document ID
    //this query removes a document from the database
    class func delete(docID: String){
        var query = PFQuery(className:"Account")
        query.getObjectInBackgroundWithId(docID) {
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
    
    //var docDictionary = [String: String]()
    //public var docList:[(docID: String, docName: String, docType: Int)] = []
    
    class func getDocList(userID: String) -> [(docID: String, docName: String, docType: Int)]{//String{ //Dictionary<String, String>{
        var docList:[(docID: String, docName: String, docType: Int)] = []
        var aString = ""
        var query = PFQuery(className:"Document")
        query.whereKey("userID", equalTo: userID)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) objects!.")
                // Do something with the found objects
                for object in objects {
                    var someID = object.objectId as String
                    var someName = object["docName"] as String
                    var someType = object["docType"] as Int
                    //self.docDictionary[someDocID] = someDocName
                    var tuple = (docID: someID, docName: someName, docType: someType)
                    docList += [tuple]
                    
                    //aString += "ID: " + someID + " Name: " + someName + " type: " + someType + "\n"
//                    println("Stored something")
                    //println("doc ID: " + someDocID + " doc name: " + someDocName)
                    //object.fetch()
                    //NSLog("%@", object.objectId)
                }
//                for someDocID in docDictionary.values{
//                    println("before printing")
//                    println("someDocID: " + someDocID)
//                }
                //
                //tuple test
//                for tuple in docList{
//                    var type: String = String(tuple.docType)
//                    print("id: " + tuple.docID )
//                    print(" name: " + tuple.docName)
//                    print(" type:  " + type + "\n")
//                }
//                for keys in docDictionary.keys{
//                    println("key: " + keys)
//                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
           //returns list by doc type

        
        return docList//docDictionary
    }
    
    class func searchDocByType(){
        
    }
    
    //used to test adding a ditionary to parse, parse saves it as an array
    class func testDictionary(){
        var dictionary = ["name": "Kevin", "id": 12345, "age": 100]
        var object = PFObject(className: "TestClass")
        object.addObject(dictionary, forKey: "infor")
        object.save()
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




