//
//  EditDocumnetViewController.swift
//  pVault
//
//  Created by Kevin Tran on 12/13/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class EditDocumnetViewController: UIViewController, DocumentView, UITextFieldDelegate  {

    var document : Document!

    
    @IBOutlet weak var docName: UITextField!
    
    @IBOutlet weak var docDesc: UITextField!
 
    @IBOutlet weak var docLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.docName.delegate = self;
        
        if(document.editEnabled == true)
        {
            docName.text = document.docName
            docDesc.text = document.docDiscription
            docLabel.text = document.docType.rawValue
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextScreen(sender: AnyObject) {
        
        document.docName = docName.text
        document.docDiscription = docDesc.text
        
        var segueString = document.docType.rawValue
        
        self.performSegueWithIdentifier(segueString, sender: self)
        
    }
    
    //removes keyboard
    override func touchesBegan(touches: NSSet?, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    //hides the keyboard when you hit return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        self.view.endEditing(true);
        return false;
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
