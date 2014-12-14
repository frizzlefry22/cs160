//
//  UserTestViewController.swift
//  pVault
//
//  Created by Arjay Nguyen on 12/3/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class UserTestViewController: UIViewController {

    var sessionUser : User!
    
    @IBAction func testGetDoc(sender: AnyObject) {
        LocalFileManager.getDocument("321", user: LoggedInuser)
    }
    @IBAction func testDeleteUser(sender: AnyObject) {
        LocalFileManager.deleteUser(LoggedInuser)
    }
    
    @IBAction func testDeleteDocument(sender: AnyObject) {
        LocalFileManager.deleteDocument("321", user: LoggedInuser)
    }
    
    @IBAction func testReturnTuples(sender: AnyObject) {
        LocalFileManager.returnDocTuples(LoggedInuser)
    }
    @IBAction func testAddDocument(sender: AnyObject) {
        var doc = Document(creatorID: "125")
        doc.objectID = "321"
        doc.docName = "documentName"
        doc.docType = DocumentType.CreditCard
        doc.setDocField(DocumentType.CreditCard)
        doc.docDiscription = "description here"
        doc.docImage = "image string"
        
        LocalFileManager.addDocument(doc, userEmail: "test@example.com", temp: false)
        doc.objectID = "temp1"
        LocalFileManager.addDocument(doc, userEmail: "test@example.com", temp: true)
    }
    
    @IBAction func testAddUser(sender: AnyObject) {
        LocalFileManager.addUser(LoggedInuser, temp: false)
    }
    
    @IBAction func testCreateUserDirectory(sender: AnyObject) {
        LocalFileManager.createUserDirectory(LoggedInuser.getEmail())
    }
    
    
    @IBAction func testCheckUserDirectory(sender: AnyObject) {
        LocalFileManager.checkUserDirectory("ar")
    }
    
    @IBAction func testEmails(sender: AnyObject) {
        var emails = UserDatabaseConnection.getEmails()
    }
    
    @IBAction func testCreate(sender: AnyObject) {
        UserDatabaseConnection.create(UserDatabaseConnection.testCreate())
        
    }
    @IBAction func testRead(sender: AnyObject) {
        var query = UserDatabaseConnection.createTestQuery()
        sessionUser = UserDatabaseConnection.read(query) as User
        println(sessionUser.getPIN())
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func testEdit(sender: AnyObject) {
        
        
        
    var user1 = LoggedInuser
    var user2 = LoggedInuser
        
        UserDatabaseConnection.edit(user1, updated: user2)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
