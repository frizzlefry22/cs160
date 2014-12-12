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
        
        var error:NSError?
        
        //attempt to create user directory in Documents path
        if NSFileManager.defaultManager().createDirectoryAtPath(userPath,
            withIntermediateDirectories: true,
            attributes: nil, error: nil){
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
    class func addDocument(newDoc: Document, userEmail: String)->Bool{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(userEmail+"/")
        let filePath = userPath + "/" + newDoc.docID
        
        //create dictionary
        var docDict:NSMutableDictionary = [
            "docID": newDoc.docID,
            "userID": newDoc.userID,
            "docName": newDoc.docName,
            //"docType": newDoc.docType.description,
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
    
    /*  addUser
    Intent:
    Pre:
    Post:
    Return:
    */
    class func addUser(user: User)->Bool{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        let filePath = userPath + "/userInfo"
        
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
    
    class func deleteUser(user: User)->Bool{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        
        if NSFileManager.defaultManager().removeItemAtPath(userPath, error: nil){
            println("user removed")
        }
        else{
            println("user not removed")
        }
        
        return true
    }
    
    class func deleteDocument(docID: String, user: User)->Bool{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        let filePath = userPath + "/" + docID
        
        if NSFileManager.defaultManager().removeItemAtPath(filePath, error: nil){
            println("doc removed")
        }
        else{
            println("doc not removed")
        }
        
        return true
    }
    
    class func getDocument(docID: String, user: User)->Document{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(user.getEmail() + "/")
        let filePath = userPath + "/" + docID
        
        //let contents = NSFileManager.defaultManager().contentsAtPath(filePath)
        let readDict: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: filePath)
        
        //create document function here
        
        return createDocumentFromFile(readDict, user: user)
    }
    
    class func createDocumentFromFile(docDict: NSMutableDictionary!, user: User)->Document{
        
        var doc = Document(creatorID: user.getUserID())
        var secQA = [String: String]()
        
        for(key, value) in docDict{
            switch key as String{
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
            //case "docType":
                //doc.docType = value as DocumentType
            default:
                secQA[key as String] = value as? String
            }
        }
        doc.docField = secQA
        
        return doc
    }
}