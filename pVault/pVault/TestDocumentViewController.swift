//
//  TestDocumentViewController.swift
//  pVault
//
//  Created by Kevin Tran on 11/23/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class TestDocumentViewController: UIViewController {

    let testDoc = Document()
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        testDoc.userID = "TestUserID"
        testDoc.docID = "testDocID"
        testDoc.docName = "Testdoc"
        testDoc.docType = DocumentType.Other
        testDoc.docDiscription = "This is a test description"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func testCreate(sender: AnyObject) {
        DocumentDBConnecion.create(DocumentDBConnecion.createDocumentPFObject(testDoc))
    }
    
    @IBAction func testRead(sender: AnyObject) {
        DocumentDBConnecion.read(DocumentDBConnecion.getSingleDocument(testDoc.docID))
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
