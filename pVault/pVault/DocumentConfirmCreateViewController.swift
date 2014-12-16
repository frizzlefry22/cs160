//
//  DocumentConfirmCreateViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 12/3/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class DocumentConfirmCreateViewController: UIViewController, DocumentView , Alertable{

    var document : Document!
    
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
            if Reachability.isConnectedToNetwork(){
                DocumentDBConnection.create(pfOb, obj: self.document);
                
                //LocalFileManager.addDocument(self.document, userEmail: LoggedInuser.getEmail(), temp: false)
            }
            else{
                LocalFileManager.addDocument(self.document, userEmail: LoggedInuser.getEmail(), temp: true)
            }
        }//edit document
        else{
            //edit document on db
            if(CurrentDocument.local == false){
            DocumentDBConnection.edit(CurrentDocument.currentDoc , updated: self.document)
            }
            else{
                LocalFileManager.editDocument(CurrentDocument.currentDoc.objectID, newDoc: self.document, user: LoggedInuser, temp: true)
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(document.editEnabled == true){
            ConfirmLabel.text = "Confirm Edit"
            createButton.setTitle("Update", forState: .Normal)
        }
        
        
        docName.text = document.docName
        docType.text = document.docType.rawValue
        
        
        imagePreview.image = Encoder.decodeImage(document.docImage)
        
        
        // Do any additional setup after loading the view.
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
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController,animated:true) {
            
        }

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
