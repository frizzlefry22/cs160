
    //  DocumentDBConnection.swift
    //  pVault
    //
    //  Created by Kevin Tran on 11/20/14.
    //  Copyright (c) 2014 Pvault2. All rights reserved.
    //
    
import Foundation

public class DocumentDBConnection: DBConnectionProtocol{
    
    //Have to do this since class var is not implemneted by Apple
    struct AlertDelStuct {
        static var alertDelegate : Alertable!
    }
    
    
    //Param takes in a PFObject
    //PFObject is saved into parse database
    //mostly done just need to get the two array and file and then test
    class func create(pfObj: PFObject, obj: AnyObject)->String{
        var objID = ""
        pfObj.saveInBackgroundWithBlock({(succeeded: Bool!, error: NSError!) -> Void in
            //success block
            if(succeeded!){
                println("File Saved")
                
                    
                AlertDelStuct.alertDelegate.AlertUser("Success")
                var doc = obj as Document
                objID = pfObj.objectId
                doc.objectID = objID
                LocalFileManager.addDocument(doc, userEmail: LoggedInuser.getEmail(), temp: false)
                
            }
                //fail block
            else{
                println("File not saved, will be saved when connection to DB is establed")
                AlertDelStuct.alertDelegate.AlertUser("File Did not Upload")
            }
        })
        return "Success"
    }
    
    //Param takes in a PFQuery
    //returns the results of a PFQuery in this case a document
    class func read(query: PFQuery) -> AnyObject{
        var imageString: String!
        //creates an empty document
        var someDoc = Document(creatorID: "")
        var docObject = query.getFirstObject()
        
        //if doc found, add fields
        if(docObject != nil){
            var fields : [String:String] = docObject["docField"] as Dictionary
            //decrypt the dictionary
            if(!isEmpty(fields)){
                for (myKey,myValue) in fields {
                    fields.updateValue(Encryptor.decrypt(myValue), forKey: myKey)
                }
            }
            
            if(docObject["docImage"] != nil){
            //get the image
            var file = docObject["docImage"] as PFFile
            var data =  file.getData()
            imageString = NSString(data: data, encoding: NSUTF8StringEncoding)
            }
            
            //fills in the document data and decrypts
            someDoc.objectID = docObject.objectId as String
            someDoc.docID = docObject["docID"] as String
            someDoc.userID = docObject["userID"] as String
            someDoc.docName = Encryptor.decrypt(docObject["docName"] as String)
            someDoc.docType = self.getType(Encryptor.decrypt(docObject["docType"] as String))
            someDoc.docDiscription = Encryptor.decrypt(docObject["docDesc"] as String)
            someDoc.docField = fields
            if(docObject["docImage"] == nil){
                someDoc.docImage = ""
            }
            else{
            someDoc.docImage = imageString
            }
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
        var currentDoc = previous as Document
        var editDoc = updated as Document

        //encrypt the doc of edit fields
        if(!isEmpty(editDoc.docField)){
            for (myKey,myValue) in editDoc.docField {
                editDoc.docField.updateValue(Encryptor.encrypt(myValue), forKey: myKey)
            }
        }
        
        self.createHistoryDocucment(currentDoc)
        self.removeHistory(currentDoc.objectID)
        var query = PFQuery(className:"Document")
        query.getObjectInBackgroundWithId(currentDoc.objectID) {
            (document: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
            } else {
                
                // upload the base64 string image string
                var image = editDoc.docImage
                var name = self.cleanName(editDoc.docName) + ".txt"
                var data = image.dataUsingEncoding(NSUTF8StringEncoding)
                var file = PFFile(name: name, data: data)
                
                document["docName"] = Encryptor.encrypt(editDoc.docName)
                document["docDesc"] = Encryptor.encrypt(editDoc.docDiscription)
                document["docField"] = editDoc.docField
                if(editDoc.docImage != ""){
                    document["docImage"] = file
                }
                document.saveInBackgroundWithBlock({(succeeded: Bool!, error: NSError!) -> Void in
                    //success block
                    if(succeeded!){
                        println("File Saved")
                        AlertDelStuct.alertDelegate.AlertUser("Success")
                        editDoc.objectID = document.objectId
                        LocalFileManager.editDocument(currentDoc.objectID, newDoc: editDoc, user: LoggedInuser, temp: false)
                    }
                        //fail block
                    else{
                        println("File not saved, will be saved when connection to DB is establed")
                        AlertDelStuct.alertDelegate.AlertUser("File Did not update")
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
    }
    
    //Param: takes in a document's object id
    //Return: returns a pfQuery
    class func deleteObject(objectID: String) -> PFQuery{
        var query = PFQuery(className:"Document")
        query.whereKey("objectId", equalTo: objectID)
        return query
    }
    
    //Param: takes in a document's object id
    //return: returns a PFQuery
    //used to remove document history (if there exist one)
    class func deleteHistory(objectID: String) -> PFQuery{
        var query = PFQuery(className:"Document")
        query.whereKey("docID", equalTo: objectID)
        return query
    }
    
    
    //Param takes in a document
    //Return creates a pfObject with document info
    //t be used with create()
    class func createDocumentPFObject(doc: Document) -> PFObject{
        var document = PFObject(className:"Document")
        
        if(!isEmpty(doc.docField)){
            for (myKey,myValue) in doc.docField {
                doc.docField.updateValue(Encryptor.encrypt(myValue), forKey: myKey)
            }
        }
        
        // upload the base64 string for image

        var image = doc.docImage
        var name = self.cleanName(doc.docName) + ".txt"
        var data = image.dataUsingEncoding(NSUTF8StringEncoding)
        var file = PFFile(name: name, data: data)

        
        //will be using parse object id for document object
        //document ID will be an empty string, will use it for document history        
        document["docID"] = doc.docID
        document["userID"] = doc.userID
        document["docName"] = Encryptor.encrypt(doc.docName)
        document["docType"] = Encryptor.encrypt(doc.docType.rawValue)
        document["docDesc"] = Encryptor.encrypt(doc.docDiscription)
        document["docField"] = doc.docField
        if(doc.docImage != ""){
        document["docImage"] = file
        }
        
        return document
    }
    
    
    //takes in a document
    //creates a copy of the document and uploads to document table 
    //this is used for history, this document would have a document id which inidicated that it's a previous version of a current document. the latest version would have the no docID but the original object id
    class func createHistoryDocucment(doc: Document){
        
        if(!isEmpty(doc.docField)){
            for (myKey,myValue) in doc.docField {
                doc.docField.updateValue(Encryptor.encrypt(myValue), forKey: myKey)
            }
        }
        
        //creates PFFiles for the image
        var image = doc.docImage
        var name = self.cleanName(doc.docName) + ".txt"
        var data = image.dataUsingEncoding(NSUTF8StringEncoding)
        var file = PFFile(name: name, data: data)

        
        var document = PFObject(className:"Document")
        document["docID"] = doc.objectID
        document["userID"] = doc.userID
        document["docName"] = Encryptor.encrypt(doc.docName)
        document["docType"] = Encryptor.encrypt(doc.docType.rawValue)
        document["docDesc"] = Encryptor.encrypt(doc.docDiscription)
        document["docField"] = doc.docField
        if(doc.docImage != ""){
        document["docImage"] = file
        }
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
        while(count >= 2)
        {
            var index = count - 1
            objectArray[index].delete()
            objectArray.removeAtIndex(index)
            count--
        }
    }
    
    //Param takes in a user id
    //Return returns a tuple that consists of doc pbject id, doc name, and doc type
    //this func returns an array of tuples which will be used to populate the document list
    class func getDocList(userID: String) -> [(objectID: String, docName: String, docType: String)]{
        var docList:[(objectID: String, docName: String, docType: String)] = []
        var query = PFQuery(className:"Document")
        query.whereKey("userID", equalTo: userID)
        query.whereKey("docID", equalTo: "")

        var objectArray = query.findObjects()
        
        for object in objectArray{
            var someID = object.objectId as String
            var someName = Encryptor.decrypt(object["docName"] as String)
            var someType = Encryptor.decrypt(object["docType"] as String)
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
            var someName = Encryptor.decrypt(object["docName"] as String)
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
    class func getType(type: String) -> DocumentType{
        switch type{
        case "Credit Card":
            return .CreditCard;
        case "Certificate":
            return .Certificate;
        case "License":
            return .License;
        case "Other":
            return .Other;
        case "None":
            return .None;
        default:
            return .None;
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
    
    class func cleanName(name: String) -> String{
        var temp = name
        //trim white space on outer edges
        temp = temp.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        //removes "
        temp = temp.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        //removes '
        temp = temp.stringByReplacingOccurrencesOfString("\'", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return temp
    }
}




