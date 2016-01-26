//
//  DocumentConfirmCreateViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 12/3/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class DocumentConfirmCreateViewController: UIViewController, DocumentView , Alertable, UITextFieldDelegate {

    var document : Document!
    var doc: PFObject!
    
    @IBOutlet weak var docName: UITextField!
    
    @IBOutlet weak var docType: UITextField!
    
    @IBOutlet weak var imagePreview: UIImageView!
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var ConfirmLabel: UILabel!
    
    @IBAction func createPushed(sender: AnyObject) {
        
        
        
        DocumentDBConnection.AlertDelStuct.alertDelegate = self
        
        //create document
        if(document.editEnabled == false){
        var pfOb = DocumentDBConnection.createDocumentPFObject(self.document)
            doc = pfOb
            if Reachability.isConnectedToNetwork(){
                
                
                //ASYNC ADD
                let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                dispatch_async(queue, async_create)
                if(self.document.docType == .None ){
                    self.moveBack(4)
                }
                else{
                    self.moveBack(5)
                }
                
                //LocalFileManager.addDocument(self.document, userEmail: LoggedInuser.getEmail(), temp: false)
            }
            else{
                if (LocalFileManager.addDocument(self.document, userEmail: LoggedInuser.getEmail(), temp: true)){
                    AlertUser("Success")
                }else{
                    AlertUser("Failed")
                }
            }
        }//edit document
        else{
            //edit document on db
            if(CurrentDocument.local == false){
            DocumentDBConnection.edit(CurrentDocument.currentDoc , updated: self.document)
            }
            else{
                if(LocalFileManager.editDocument(CurrentDocument.currentDoc.objectID, newDoc: self.document, user: LoggedInuser, temp: true)){
                    AlertUser("Success")
                }else{
                    AlertUser("Failed")
                }
                
            }
        }

    }
    
    func async_create(){
        DocumentDBConnection.create(doc, obj: self.document);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.docName.delegate = self;
        self.docType.delegate = self;
        
        if(document.editEnabled == true){
            ConfirmLabel.text = "Confirm Edit"
            createButton.setTitle("Update", forState: .Normal)
        }
        
        
        docName.text = document.docName
        docType.text = document.docType.rawValue
        
        
        imagePreview.image = Encoder.decodeImage(document.docImage)
        
        
        // Do any additional setup after loading the view.
    }

    //hides the keyboard when you hit return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        self.view.endEditing(true);
        return false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //param: message to be displayed
    //the alert message
    func AlertUser(message : String) {
        var messageA: String!
        if(document.editEnabled == true){
            messageA = "Document Edit"
        }
        else{
            messageA = "Document Upload"
        }
        
        let alertController = UIAlertController(title: messageA, message: message, preferredStyle: .Alert)
        
        
        
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action) in
            
            //if this is document editing
            if(self.document.editEnabled == true){
                //go back to home screen on success
                if(message == "Success"){
                    //if doctype = none move back one less than other types
                    if(self.document.docType == .None ){
                        self.moveBack(6)
                    }
                    else{
                        self.moveBack(7)
                    }
                }
                    //if fail to save edit stay here and does nothing
                else{}
            }
                //else this document creation
            else{
                if(message == "Success"){
                    //if doctype = none move back one less than other types
                    if(self.document.docType == .None ){
                        self.moveBack(4)
                    }
                    else{
                        self.moveBack(5)
                    }
                }
                    //if fail to create stay here and does nothing
                else{}
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), {
        alertController.addAction(okAction)
            self.navigationController?.topViewController.presentViewController(alertController, animated: true, completion: {})
        })
    }
    
    //param: takes in number of screens to move back
    //to move from confirm screen back to home
    func moveBack(num : Int)
    {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - num], animated: true);
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
