//
//  BirthCertificateViewController.swift
//  pVault
//
//  Created by Joseph Orlando on 11/30/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class BirthCertificateViewController: UIViewController, DocumentView, UITextFieldDelegate  {

    //Protocol stuff
    var document : Document!
    
    @IBOutlet weak var certName: UITextField!
    @IBOutlet weak var certDOB: UITextField!
    @IBOutlet weak var certPOB: UITextField!
    @IBOutlet weak var certParentsName: UITextField!
    @IBOutlet weak var certNumber: UITextField!
    
    @IBOutlet weak var docNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.certName.delegate = self;
        self.certDOB.delegate = self;
        self.certPOB.delegate = self;
        self.certParentsName.delegate = self;
        self.certNumber.delegate = self;
        self.docNameTextField.delegate = self;

        docNameTextField.text = document.docName
        
        if ( document.editEnabled! ) {
            populateFields(document.docField)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Sets the UI to the previous fields
    func populateFields( fields : [String:String]) {
        
        certName.text =  fields["CertificateName"]
        certDOB.text =  fields["Date of Birth"]
        certPOB.text =  fields["Place of Birth"]
        certParentsName.text =  fields["Parents Name"]
        certNumber.text =  fields["Number"]
        
    }

    //hides the keyboard when you hit return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        self.view.endEditing(true);
        return false;
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var fieldDictionary = [String:String]()
        
        fieldDictionary["CertificateName"] = certName.text
        fieldDictionary["Date of Birth"] = certDOB.text
        fieldDictionary["Place of Birth"] = certPOB.text
        fieldDictionary["Parents Name"] = certParentsName.text
        fieldDictionary["Number"] = certNumber.text
        
        document.docField = fieldDictionary
        
        let vc = segue.destinationViewController as DocPhotoViewController
        
        vc.document = document
        
    }


}
