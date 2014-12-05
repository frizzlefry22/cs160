//
//  TestDocumentViewController.swift
//  pVault
//
//  Created by Kevin Tran on 11/23/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class TestDocumentViewController: UIViewController {

    let testDoc = Document(creatorID: "Kevin")
    
    var readDoc = Document(creatorID: "")
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var dictionary = ["Card Holder": "Kevin Tran", "Credit Card Number": "1111222233334444", "Security Pin": "911", "Expiration Date": "12/15"]
        testDoc.objectID = "moDLWCFbBJ"
        testDoc.docID = ""
        testDoc.userID = "Kevin"
        testDoc.docName = "Doc1"
        testDoc.docType = DocumentType.CreditCard
        testDoc.docField = ["Card Holder": "Kevin Tran", "Credit Card Number": "1111222233334444", "Security Pin": "911", "Expiration Date": "12/15"]
        testDoc.docDiscription = "BOA master card 1.5% cash back"
        testDoc.docImage = "CreditCardImage"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func testCreate(sender: AnyObject) {
        DocumentDBConnecion.create(DocumentDBConnecion.createDocumentPFObject(testDoc))
    }
    
    @IBAction func testRead(sender: AnyObject) {
        readDoc = DocumentDBConnecion.read(testDoc.objectID)
        var num = String(readDoc.getDocType(readDoc.docType))
        print("Object id: " + readDoc.objectID + "\n")
        print("Doc id: " + readDoc.docID + "\n")
        print("User id: " + readDoc.userID + "\n")
        print("Doc Name: " + readDoc.docName + "\n")
        print("Doc Type: " + num + "\n")
        print("Doc Description: " + readDoc.docDiscription + "\n")
        print("Doc Image: " + readDoc.docImage + "\n")
        
        var diction: Dictionary = readDoc.docField
        for (myKey,myValue) in diction{
            println("\(myKey) \t \(myValue)")
        }
    }
    
    @IBAction func testList(sender: AnyObject) {
        var temp =  DocumentDBConnecion.getDocList("Kevin")
        for tuple in temp{
            var type: String = String(tuple.docType)
            print("id: " + tuple.objectID )
            print(" name: " + tuple.docName)
            print(" type:  " + type + "\n")
        }
    }

    @IBAction func testDictionary(sender: AnyObject) {
        //test inserting dictionary
        //DocumentDBConnecion.testDictionary()
        
        //test getting dictionary
        DocumentDBConnecion.testGetDictionary(testDoc.objectID)
    }
    
    @IBAction func testEdit(sender: AnyObject) {
        var editDoc =  Document(creatorID: "")
        editDoc.docName = "doc2"
        editDoc.docDiscription = "This is my new BOA  mastercard with 5% back on everything?!!!!"
        editDoc.docField = ["Card Holder": "Kevin H Tran", "Credit Card Number": "1122334455667788", "Security Pin": "411", "Expiration Date": "12/18"]
        editDoc.docImage = "newCCImage"
        DocumentDBConnecion.editSomething(readDoc, editDoc: editDoc)
    }
    
    @IBAction func testHistory(sender: AnyObject) {
        var temp = DocumentDBConnecion.getHistory(readDoc.objectID)
        for thing in temp{
            print("id: " + thing.objectID)
            print(" name: " + thing.docName)
            println()
        }
        
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
