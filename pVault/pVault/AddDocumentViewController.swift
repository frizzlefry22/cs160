//
//  AddDocumentViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 11/29/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class AddDocumentViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate {
    
    var currentSelected : String!
    
    
    @IBOutlet weak var thePickerView: UIPickerView!
    
    @IBOutlet weak var docTitle: UITextField!
    
    
    @IBOutlet weak var descTextView: UITextView!
    
    
    @IBAction func nextPushed(sender: AnyObject) {
        
        //Fix bug of None not being selected unless you move picker
        if (currentSelected == nil)
        {
            currentSelected = DocumentType.None.rawValue
        }
        
        //Performs Segue based on the UIPicker Selecetd
        performSegueWithIdentifier( currentSelected , sender : sender)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let userID = LoggedInuser.getUserID()
        
        let newDoc = Document(creatorID: userID)
        
        newDoc.docName = docTitle.text
        
        newDoc.docDiscription = descTextView.text
        
        //Checks to make sure the destination viewController is a DocumentView
        if let vc = segue.destinationViewController as? DocumentView {
            
            //NewDoc Editing should be turned off since its in creation mode
            newDoc.editEnabled = false
            
            newDoc.docType = DocTypeFromString(currentSelected)
            vc.document = newDoc
            
        }
        else {
            println("Error")
        }
        
    }
    
    
    
    let doctype = [ DocumentType.None.rawValue, DocumentType.CreditCard.rawValue, DocumentType.Certificate.rawValue, DocumentType.License.rawValue]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.docTitle.delegate = self;
        //descTextView.inputView = UIView(frame: CGRectZero)
        //navigation
        
        thePickerView.delegate = self
        thePickerView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //hides the keyboard when you hit return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        self.view.endEditing(true);
        return false;
    }

    //
    override func touchesBegan(touches: NSSet?, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    //Stuff for the UIPicker
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
       return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int {
        
        return doctype.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return doctype[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelected = doctype[row]
    }

}
