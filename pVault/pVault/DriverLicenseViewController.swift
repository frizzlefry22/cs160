//
//  DriverLicenseViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 11/30/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class DriverLicenseViewController: UIViewController, DocumentView, UITextFieldDelegate  {

    @IBOutlet weak var docNameTextField: UITextField!
    
    @IBOutlet weak var licenseName: UITextField!
    
    @IBOutlet weak var licenseDOB: UITextField!
    
    @IBOutlet weak var licenseNum: UITextField!
    
    @IBOutlet weak var licenseExp: UITextField!
    
    @IBOutlet weak var licenseClass: UITextField!
    
    @IBOutlet weak var licenseAddress: UITextView!
    
    //DocumentViewProtocol
    var document : Document!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.licenseName.delegate = self;
        self.licenseDOB.delegate = self;
        self.licenseNum.delegate = self;
        self.licenseExp.delegate = self;
        self.licenseClass.delegate = self;
        self.docNameTextField.delegate = self;
        
        //licenseAddress.inputView = UIView(frame: CGRectZero)

        docNameTextField.text = document.docName
        
        if ( document.editEnabled! )
        {
            populateFields(document.docField)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateFields(fields : [String:String]) {
        
        licenseName.text =  fields["LicenseName"]
        licenseDOB.text =  fields["LicneseDOB"]
        licenseNum.text =  fields["LicenseNum"]
        licenseClass.text = fields["LicenseClass"]
        licenseExp.text =  fields["LicenseExpiration"]
        licenseAddress.text =  fields["LicenseAddress"]
        
    }

    //hides the keyboard when you hit return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        self.view.endEditing(true);
        return false;
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var fieldDictionary = [String:String]()
        
        fieldDictionary["LicenseName"] = licenseName.text
        fieldDictionary["LicneseDOB"] = licenseDOB.text
        fieldDictionary["LicenseNum"] = licenseNum.text
        fieldDictionary["LicenseClass"] = licenseClass.text
        fieldDictionary["LicenseExpiration"] = licenseExp.text
        fieldDictionary["LicenseAddress"] = licenseAddress.text
        
        document.docField = fieldDictionary
        
        let vc = segue.destinationViewController as DocPhotoViewController
        vc.document = self.document
        
        
    }
    

}
