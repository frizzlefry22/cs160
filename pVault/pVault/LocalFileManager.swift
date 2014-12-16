//
//  LocalFileManager.swift
//  pVault
//
//  Created by Arjay Nguyen on 12/8/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

class LocalFileManager{
    
    
    
    /*  createUserDirectory
    
        Intent:
        Pre:
        Post:
        Return:
    */
    class func createUserDirectory(userEmail: String)->Bool{
        //get path to documents folder
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        //append userID to documents path to create specific folder for user
        let userPath = documentsPath.stringByAppendingPathComponent(userEmail+"/")
        let syncPath = userPath + "/Synced/"
        let unsyncPath = userPath + "/Unsynced/"
        var error:NSError?
        
        //attempt to create user directory in Documents path
        if NSFileManager.defaultManager().createDirectoryAtPath(syncPath,
            withIntermediateDirectories: true,
            attributes: nil, error: nil)
            && NSFileManager.defaultManager().createDirectoryAtPath(unsyncPath,
                withIntermediateDirectories: true, attributes: nil, error: nil){
                    
                println("Directory created")
                return true
        }
        
        
        
        println("Directory not created")
        return false
    }
    
    
    /*  checkUserDirectory
    
    Intent:
    Pre:
    Post:
    Return:
    */
    class func checkUserDirectory(userEmail: String)->Bool{
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        
        if urls.count <= 0{
            println("Documents folder not found")
            return false
        }
        
        let documentsFolder = urls[0]
        let userURL = documentsFolder.URLByAppendingPathComponent(userEmail+"/")
        
        if NSFileManager.defaultManager().fileExistsAtPath(userURL.path!){
            println("user directory exists")
            return true
        }
        
        return false
    }

    /*  addDocument
    
    Intent:
    Pre:
    Post:
    Return:
    */
    class func addDocument(newDoc: Document, userEmail: String, temp: Bool)->Bool{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        var syncPath = ""
        let userPath = documentsPath.stringByAppendingPathComponent(userEmail+"/")
        if temp{
            syncPath = userPath + "/Unsynced"
            var tempID = getNextTempNum(userEmail)
            newDoc.objectID = "temp" + String(tempID)
        }else{
            syncPath = userPath + "/Synced"
        }
        
        let filePath = syncPath + "/" + newDoc.objectID
        
        //create dictionary
        var docDict:NSMutableDictionary = [
            "objectID": newDoc.objectID,
            "docImage": "image string",// newDoc.docImage,
            "docID": newDoc.docID,
            "userID": newDoc.userID,
            "docName": newDoc.docName,
            "docType": newDoc.getDocType(newDoc.docType),
            "docDiscription": newDoc.docDiscription,
        ]
        for (key, value) in newDoc.docField{
            docDict[key] = value
        }
        docDict["docImage"] = newDoc.docImage
        
        if docDict.writeToFile(filePath, atomically: true){
            let readDict:NSDictionary? = NSDictionary(contentsOfFile: filePath)
            if let dict = readDict{
                println("Read the dictionary back from disk = \(dict)")
            }else{
                println("Failed to read the dictionary back from disk")
            }
        }else{
            println("Failed to write the dictionary to disk")
        }

        return true
    }
    
    class func getNextTempNum(userEmail: String)->Int{
        var next = 1
        
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let userPath = documentsPath.stringByAppendingPathComponent(userEmail+"/")
        let syncPath = userPath + "/Unsynced/"
        
        
        var syncContents = NSFileManager.defaultManager().contentsOfDirectoryAtPath(syncPath, error: nil)!
        
        for file in syncContents{
            var fileName = file as String
            var lastNum = fileName.substringWithRange(Range<String.Index>(start: advance(fileName.startIndex, 4), end: fileName.endIndex)) //"Hello, playground"
            if lastNum.toInt() >= next{
                next = lastNum.toInt()! + 1
            }
        }
        
        return next
    }
    
    /*  addUser
    Intent:
    Pre:
    Post:
    Return:
    */
    class func addUser(user: User, temp: Bool)->Bool{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        var syncPath = ""
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        if temp {
            syncPath = userPath + "/Unsynced"
        }else{
            syncPath = userPath + "/Synced"
        }
        let filePath = syncPath + "/userInfo"
        
        var userDict: NSMutableDictionary = [
        "userID": user.getUserID(),
        "email": user.getEmail(),
        "password": user.getPassword(),
        "PIN": user.getPIN()
        ]
        
        for(key, value) in user.getSecQA(){
            userDict[key] = value
        }
        
        if userDict.writeToFile(filePath, atomically: true){
            let readDict:NSDictionary? = NSDictionary(contentsOfFile: filePath)
            if let dict = readDict{
                println("Read the dictionary back from disk = \(dict)")
            }else{
                println("Failed to read the dictionary back from disk")
            }
        }else{
            println("Failed to write the dictionary to disk")
        }
        
        return true
    }
    
    class func getUser(userEmail: String)->User{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(userEmail + "/")
        let syncPath = userPath + "/Synced/userInfo"
        let unsyncPath = userPath + "/Unsynced/userInfo"
        var readDict: NSMutableDictionary!
        
        if NSFileManager.defaultManager().fileExistsAtPath(syncPath){
            readDict = NSMutableDictionary(contentsOfFile: syncPath)
        }else{
            readDict = NSMutableDictionary(contentsOfFile: unsyncPath)
        }
        
        
        
        
        return createUserFromFile(readDict)
    }
    
    
    class func createUserFromFile(userDict: NSMutableDictionary!)->User{
        var user = User()
        var secQA = [String: String]()
        
        for(key, value) in userDict{
            switch key as String{
            case "userID":
                user.setUserID(value as String)
            case "email":
                user.setEmail(value as String)
            case "password":
                user.setPassword(value as String)
            case "PIN":
                user.setPIN(value as String)
            default:
                secQA[key as String] = value as? String
            }
        }
        user.setSecQA(secQA)
        
        return user
    }
    
    class func deleteUser(user: User)->Bool{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        //let syncPath = userPath + "Synced/userInfo"
        //let unsyncPath = userPath + "Unsynced/userInfo"
        

        if NSFileManager.defaultManager().removeItemAtPath(userPath, error: nil){
            println("user removed")
        }
        else{
            println("user not removed")
        }
        
        return true
    }
    
    class func deleteDocument(objectID: String, user: User)->Bool{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        let syncPath = userPath + "/Synced/" + objectID
        let unsyncPath = userPath + "/Unsynced/" + objectID
        
        
        if NSFileManager.defaultManager().removeItemAtPath(syncPath, error: nil) ||
            NSFileManager.defaultManager().removeItemAtPath(unsyncPath, error: nil){
                println("Document removed")
        }
        else{
            println("Document not removed")
        }
        
        return true
    }
    
    class func syncDocuments(user: User){
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        let syncPath = userPath + "/Unsynced"
        var doc = Document(creatorID: user.getUserID())
        
        var unsyncContents = NSFileManager.defaultManager().contentsOfDirectoryAtPath(syncPath, error: nil)!
        
        for file in unsyncContents{
            //get file name as string
            var fileName: String? = file as? String
            //check if document file
            if(fileName != "userInfo"){
                let filePath = syncPath + "/" + fileName!
                var docDict: NSMutableDictionary! = NSMutableDictionary(contentsOfFile: filePath)
                
                //create document from file
                var doc = createDocumentFromFile(docDict, user: user)
                
                
                
                if doc.objectID.rangeOfString("temp") != nil{
                    //add
                    var pfObj = DocumentDBConnection.createDocumentPFObject(doc)
                    //delete temp doc
                    deleteDocument(doc.objectID, user: LoggedInuser)
                    DocumentDBConnection.create(pfObj, obj: doc)
                }else{
                    //edit
                    DocumentDBConnection.edit(doc, updated: doc)
                }
            }
            
        }
        
    }
    class func editDocument(objectID: String, newDoc: Document, user: User, temp: Bool){
        //let oldDoc = getDocument(objectID, user: user)
        
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        let syncPath = userPath + getDocStatus(objectID, user: user)
        let unsyncPath = userPath + "/Unsynced/" + objectID
        let filePath = syncPath + "/" + objectID
        
        var docDict:NSMutableDictionary = [
            "objectID": objectID,
            "docImage": newDoc.docImage,
            "docID": newDoc.docID,
            "userID": newDoc.userID,
            "docName": newDoc.docName,
            "docType": newDoc.getDocType(newDoc.docType),
            "docDiscription": newDoc.docDiscription,
        ]
        
        for (key, value) in newDoc.docField{
            docDict[key] = value
        }
        
        docDict["docImage"] = newDoc.docImage
        
        if(temp){
            //delete from sync documents
            deleteDocument(objectID, user: LoggedInuser)
            //add to unsync documents
            if docDict.writeToFile(unsyncPath, atomically: true){
                let readDict:NSDictionary? = NSDictionary(contentsOfFile: filePath)
                if let dict = readDict{
                    println("Read the dictionary back from disk = \(dict)")
                }else{
                    println("Failed to read the dictionary back from disk")
                }
            }else{
                println("Failed to write the dictionary to disk")
            }
        }else{
            if docDict.writeToFile(filePath, atomically: true){
                let readDict:NSDictionary? = NSDictionary(contentsOfFile: filePath)
                if let dict = readDict{
                    println("Read the dictionary back from disk = \(dict)")
                }else{
                    println("Failed to read the dictionary back from disk")
                }
            }else{
                println("Failed to write the dictionary to disk")
                }
        }
        
        
    }
    
    class func getDocStatus(objectID: String, user: User)->String{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        let syncPath = userPath + "/Synced/" + objectID
        let unsyncPath = userPath + "/Unsynced/" + objectID
        
        if NSFileManager.defaultManager().fileExistsAtPath(syncPath){
            return "/Synced"
        }
        
        if NSFileManager.defaultManager().fileExistsAtPath(unsyncPath){
            return "/Unsynced"
        }
        
        return ""
    }
    
    class func getDocument(objectID: String, user: User)->Document{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        let syncPath = userPath + "/Synced/" + objectID
        let unsyncPath = userPath + "/Unsynced/" + objectID
        
        //let contents = NSFileManager.defaultManager().contentsAtPath(filePath)
        var readDict: NSMutableDictionary!
        
        if NSFileManager.defaultManager().fileExistsAtPath(syncPath){
            readDict = NSMutableDictionary(contentsOfFile: syncPath)
        }else{
            readDict = NSMutableDictionary(contentsOfFile: unsyncPath)
        }
        
        //create document function here
        
        return createDocumentFromFile(readDict, user: user)
    }
    
    
    class func createDocumentFromFile(docDict: NSMutableDictionary!, user: User)->Document{
        
        var doc = Document(creatorID: user.getUserID())
        var fields = [String: String]()
        
        for(key, value) in docDict{
            switch key as String{
            case "objectID":
                doc.objectID = value as String
            case "docID":
                doc.docID = value as String
            case "userID":
                doc.userID = value as String
            case "docName":
                doc.docName = value as String
            case "docDiscription":
                doc.docDiscription = value as String
            case "docImage":
                doc.docImage = value as String
            case "docType":
                doc.docType = DocTypeFromString(value as String)
            default:
                fields[key as String] = value as? String
            }
        }
        doc.docField = fields
        
        return doc
    }
    
    class func returnDocTuples(user: User)->[(objectID: String, docName: String, docType: String)]{
        
        //grab all files from user folder
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        let syncPath = userPath + "/Synced/"
        let unsyncPath = userPath + "/Unsynced/"
        var syncContents = NSFileManager.defaultManager().contentsOfDirectoryAtPath(syncPath, error: nil)!
        
        //init empty tuples array
        var tuples:[(objectID: String, docName: String, docType: String)] = []

        //get doc tuples for every document
        for file in syncContents{
            
            //get file name as string
            var fileName: String? = file as? String
            //check if document file
            if(fileName != "userInfo"){
                let filePath = syncPath + "/" + fileName!
                var docDict: NSDictionary! = NSDictionary(contentsOfFile: filePath)
                
                tuples.append(objectID: docDict["objectID"] as String,
                    docName: docDict["docName"] as String,
                    docType: docDict["docType"] as String)
            }
        }
        var unsyncContents = NSFileManager.defaultManager().contentsOfDirectoryAtPath(unsyncPath, error: nil)!
        
        for file in unsyncContents{
            
            //get file name as string
            var fileName: String? = file as? String
            //check if document file
            if(fileName != "userInfo"){
                let filePath = unsyncPath + "/" + fileName!
                var docDict: NSDictionary! = NSDictionary(contentsOfFile: filePath)
                
                tuples.append(objectID: docDict["objectID"] as String,
                    docName: docDict["docName"] as String,
                    docType: docDict["docType"] as String)
            }

        }
        
        //return tuples array
        return tuples
    }
    
}