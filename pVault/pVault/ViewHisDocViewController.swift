//
//  ViewHisDocViewController.swift
//  pVault
//
//  Created by Kevin Tran on 12/12/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ViewHisDocViewController: UIViewController {

    var objectId: String!
    var document: Document!
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var docType: UILabel!
    
    @IBOutlet weak var docField: UITextView!
    
    @IBOutlet weak var docDesc: UITextView!
    
    @IBOutlet weak var docImage: UIImageView!
    
    @IBAction func EnlargeImage(sender: AnyObject) {
        if(!isEmpty(document.docImage)){
             self.performSegueWithIdentifier("viewHistoryImage", sender: self)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var docFieldString = ""
        //read document
        document = DocumentDBConnection.read(DocumentDBConnection.readObject(objectId)) as Document
        
        //document name
        testLabel.text = document.docName
        docType.text = "Document Type: " + document.docType.rawValue
        
        //concat doc feilds
        if(!isEmpty(document.docField)){
            for (myKey,myValue) in document.docField {
                docFieldString = docFieldString + "\(myKey): \(myValue)\n\n"
                
            }
            docField.text = docFieldString
        }
        else{
            docField.text = ""
        }
        
        //concat doc Description
        if(!isEmpty(document.docDiscription)){
            docDesc.text = "Description: \n" + document.docDiscription
        }
        else{
            docDesc.text = ""
        }
        
        
        docImage.image = Encoder.decodeImage(document.docImage)
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
        var vc = segue.destinationViewController as ViewImageViewController
        vc.document = self.document    }


}
