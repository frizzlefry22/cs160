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
    
    
    @IBAction func createPushed(sender: AnyObject) {
        
        
        DocumentDBConnection.AlertDelStuct.alertDelegate = self
        
        //Display the image
        var pfOb = DocumentDBConnection.createDocumentPFObject(self.document)
        DocumentDBConnection.create(pfOb);
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        docName.text = document.docName
        docType.text = document.docType.rawValue
        
        
        imagePreview.image = Encoder.decodeImage(document.docImage)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func AlertUser(message : String) {
        let alertController = UIAlertController(title: "Document Upload", message: message, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action) in
        }
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController,animated:true) {
            
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
