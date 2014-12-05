//
//  AddDocumentViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 11/29/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class AddDocumentViewController: UIViewController, UIPickerViewDelegate{
    
    var currentSelected : String!
    
    
    
    @IBOutlet weak var docTitle: UITextField!
    
    
    @IBOutlet weak var descTextView: UITextView!
    
    
    @IBAction func nextPushed(sender: AnyObject) {
        
        //Performs Segue based on the UIPicker Selecetd
        performSegueWithIdentifier( currentSelected , sender : sender)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let userID = LoggedInuser.getUserID()
        
        let newDoc = Document(creatorID: userID)
        
        
        newDoc.docName = docTitle.text
        
        newDoc.docDiscription = descTextView.text
        
        
        if ( segue.identifier == DocumentType.CreditCard.rawValue ){
        
            let vc = segue.destinationViewController as CreditCardViewController
            
            //Propograte the document
            vc.document = newDoc
            
            //vc.delegate = self
        }
        else if (segue.identifier == DocumentType.None.rawValue)
        {
            let vc = segue.destinationViewController as
            DocPhotoViewController
            
            vc.document = newDoc
        }
        else if ( segue.identifier ==  DocumentType.Certificate.rawValue)
        {
            let vc = segue.destinationViewController as BirthCertificateViewController
            
            vc.document = newDoc
        }
        else if ( segue.identifier == DocumentType.License.rawValue)
        {
            let vc = segue.destinationViewController as DriverLicenseViewController
            
            vc.document = newDoc
        }

        
    }
    
    
    
    var doctype = [ DocumentType.None.rawValue, DocumentType.CreditCard.rawValue, DocumentType.Certificate.rawValue, DocumentType.License.rawValue, DocumentType.Other.rawValue]

    override func viewDidLoad() {
        super.viewDidLoad()

        //navigation
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
    
       return 1
    

    }

    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) ->Int {
        
        return doctype.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String {
        
        currentSelected = doctype[row]
        return doctype[row]
    }
}
