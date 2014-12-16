//
//  ViewDocumentViewController.swift
//  pVault
//
//  Created by Kevin Tran on 12/11/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ViewDocumentViewController: UIViewController {
    
    var document: Document!
    var segueString: String!
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var docType: UILabel!
    
    @IBOutlet weak var docField: UITextView!

    @IBOutlet weak var docDesc: UITextView!
    
    @IBOutlet weak var docImage: UIImageView!
    
    @IBOutlet weak var historyButton: UIButton!
    
    //view enlarged image
    @IBAction func enlargeImage(sender: AnyObject) {
        
        segueString = "viewImage"
        if(!isEmpty(document.docImage)){
            self.performSegueWithIdentifier(segueString, sender: self)
        }
    }
    
    //view doc history list
    @IBAction func viewDocHistory(sender: AnyObject) {
        var temp = DocumentDBConnection.getHistory(document.objectID)
        
        //checks if its local and displays history
        if(CurrentDocument.local == true){
            historyButton.enabled = false
        }
        
        segueString = "viewHistory"
        //if there is history move to screen
        if(!isEmpty(temp)){
            self.performSegueWithIdentifier(segueString, sender: self)
        }
            //else, alert no history
        else{
            let alertController = UIAlertController(title: "No History", message: "Document: " + document.docName + " has no history.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController,animated:true) {}
        }
    }
    
    //edit button goes to edit view
    @IBAction func editDocument(sender: AnyObject) {
        segueString = "editView"
        CurrentDocument.currentDoc = self.document.clone(self.document)
        document.editEnabled = true
        self.performSegueWithIdentifier(segueString, sender: self)
    }

    //load the document on load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //doc fields
        var docFieldString = ""

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
        //checks if the image is empty, if its empty dont display it
        if(document.docImage == ""){
            
        }
        else{
        docImage.image = Encoder.decodeImage(document.docImage)
        }
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
            //deletes this document
            //if its not a local
            if(!CurrentDocument.local){
                DocumentDBConnection.delete(DocumentDBConnection.deleteObject(self.document.objectID))
                
                LocalFileManager.deleteDocument(self.document.objectID, user: LoggedInuser)
                //if there is history, delete them
                if(!isEmpty(DocumentDBConnection.getHistory(self.document.objectID))){
                    DocumentDBConnection.delete(DocumentDBConnection.deleteHistory(self.document.objectID))
                    
                }
            } else{
//local document removal here
                LocalFileManager.deleteDocument(self.document.objectID, user: LoggedInuser)
            }
            
            
            //move back home
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
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
