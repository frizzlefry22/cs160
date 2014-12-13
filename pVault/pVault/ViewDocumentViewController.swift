//
//  ViewDocumentViewController.swift
//  pVault
//
//  Created by Kevin Tran on 12/11/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ViewDocumentViewController: UIViewController {
    
    var objectId: String!
    var document: Document!
    
    var segueString: String!
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var docType: UILabel!
    
    @IBOutlet weak var docField: UITextView!

    @IBOutlet weak var docDesc: UITextView!
    
    @IBOutlet weak var docImage: UIImageView!
    //view enlarged image

    @IBAction func enlargeImage(sender: AnyObject) {
        segueString = "viewImage"
        if(!isEmpty(document.docImage)){
            self.performSegueWithIdentifier(segueString, sender: self)
        }
    }
    
    //view doc history list
    @IBAction func viewDocHistory(sender: AnyObject) {
        segueString = "viewHistory"
        //will add an alert here
            self.performSegueWithIdentifier(segueString, sender: self)
    }
    
    //load the document on load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //doc fields
        var docFieldString = ""
        
        //get document from db
        document = DocumentDBConnection.read(DocumentDBConnection.readObject(objectId)) as Document
        
        //doc name
        testLabel.text = document.docName
        docType.text = "Document Type: " + document.docType.rawValue
        
        //concat the fields
        if(!isEmpty(document.docField)){
            for (myKey,myValue) in document.docField {
                docFieldString = docFieldString + "\(myKey): \(myValue)\n\n"
                
            }
            docField.text = docFieldString
        }
        else{
            docField.text = ""
        }
        
        //concat the desc
        if(!isEmpty(document.docDiscription)){
        docDesc.text = "Description: \n" + document.docDiscription
        }
        else{
            docDesc.text = ""
        }
        
        //document image
        docImage.image = Encoder.decodeImage(document.docImage)
    }
    
    @IBAction func deleteDocument(sender: AnyObject) {
        let alertController = UIAlertController(title: "Confirm Deletion", message: "Deleting document: " + document.docName, preferredStyle: .Alert)
        
        //add cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            println(action)
        }
        alertController.addAction(cancelAction)
        
        //add confirm action
        let confirmAction = UIAlertAction(title: "Confirm", style: .Default) { (action) in
            println("delete something here")
        }
        alertController.addAction(confirmAction)
        
        self.presentViewController(alertController,animated:true) {}
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var vc = segue.destinationViewController as DocumentView
        vc.document = self.document
    }


}
