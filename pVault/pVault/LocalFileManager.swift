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
    class func createUserDirectory(userID: String)->Bool{
        //get path to documents folder
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        //append userID to documents path to create specific folder for user
        let userPath = documentsPath.stringByAppendingPathComponent(userID+"/")
        
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
    class func checkUserDirectory(userID: String)->Bool{
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        
        if urls.count <= 0{
            println("Documents folder not found")
            return false
        }
        
        let documentsFolder = urls[0]
        let userURL = documentsFolder.URLByAppendingPathComponent(userID+"/")
        
        if NSFileManager.defaultManager().fileExistsAtPath(userURL.path!){
            println("user directory exists")
            return true
        }
        
        return false
    }
    
    class func addDocument(newDoc: Document, userID: String)->Bool{
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let userPath = documentsPath.stringByAppendingPathComponent(userID+"/")
        let filePath = userPath + "/" + newDoc.docID
        
        //create dictionary
        var docDict:NSMutableDictionary = [
            "docID": newDoc.docID,
            "userID": newDoc.userID,
            "docName": newDoc.docName,
            "docType": newDoc.docType.description,
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
}