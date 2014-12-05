
    //  DocumentDBConnection.swift
    //  pVault
    //
    //  Created by Kevin Tran on 11/20/14.
    //  Copyright (c) 2014 Pvault2. All rights reserved.
    //
    
import Foundation

public class DocumentDBConnection: DBConnectionProtocol{
    
    
    
    
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
    //returns the results of a PFQuery in this case a document
    class func read(query: PFQuery) -> AnyObject{
        //creates an empty document
        var someDoc = Document(creatorID: "")
        var docObject = query.getFirstObject()
        
        //if doc found, add fields
        if(docObject != nil){
            
        //fills in the document data
        someDoc.objectID = docObject.objectId as String
        someDoc.docID = docObject["docID"] as String
        someDoc.userID = docObject["userID"] as String
        someDoc.docName = docObject["docName"] as String
        someDoc.docType = self.getType(docObject["docType"] as Int)
        someDoc.docDiscription = docObject["docDesc"] as String
        someDoc.docField = docObject["docField"] as Dictionary
        someDoc.docImage = docObject["docImage"] as String
        }
        return someDoc
    }
    
    //creates a PFQuery to read a document 
    //Param: takes in a document's object id
    //return: returns a query
    class func readObject(objectID: String) -> PFQuery{
        var query = PFQuery(className:"Document")
        query.whereKey("objectId", equalTo: objectID)
        return query
    }
    
    //Param takes in an existing document 
    //Calls createHistoryDocument to put the current document into a new PFObject to keep in history 
    //Calls removeHistory to remove previous versions if there are more than 2 previous version
    //only allowed to change document name, description, fields, and image
    class func edit(previous: AnyObject, updated: AnyObject) {//-> PFQuery{
        var currentDoc = updated as Document
        var editDoc = previous as Document

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
    class func delete(query: PFQuery){
        var aQuery = query
        aQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) scores.")
                // Delete the objects if found
                for object in objects {
                    object.delete()
                    println("Successfully deleted document(s).")
                    NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                println("Failed to delete document(s).")
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
            println("Deleted document")
            //------------
//        aQuery.getObjectInBackgroundWithId(objectID) {
//            (document: PFObject!, error: NSError!) -> Void in
//            if error == nil {
//                document.delete()
//                NSLog("%@", document)
//            } else {
//                NSLog("%@", error)
//            }
//        }
//        println("Deleted document")
    }
    
    //Param: takes in a document's object id
    //Return: returns a pfQuery
    class func deleteObject(objectID: String) -> PFQuery{
        var query = PFQuery(className:"Document")
        query.whereKey("objectId", equalTo: objectID)
        return query
    }
    class func deleteHistory(objectID: String) -> PFQuery{
        var query = PFQuery(className:"Document")
        query.whereKey("docID", equalTo: objectID)
        return query
    }
    
    //Param takes in a user ID
    //Return a PFQuery
    //Used to query a all documents from one user ID used to populate a list
    //will be removing these two methods
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
    //t be used with create()
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
    //for used inside edit
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
    class func getDocList(userID: String) -> [(objectID: String, docName: String, docType: Int)]{
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
        return docList
    }
    
    //Param takes in a document's object id 
    //return a list of at most 2 previous versions of the document
    //for viewing the previous docs
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
            return .Creditcard;
        case 1:
            return .BirthCertificate;
        case 2:
            return .DriverLicense;
        case 3:
            return .Other;
        default:
            return .Other;
        }
    }
    
    //test to get dictionary
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




