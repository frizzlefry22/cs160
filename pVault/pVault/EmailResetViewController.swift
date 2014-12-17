//
//  EmailResetViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 12/10/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class EmailResetViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var emailInput: UITextField!
    
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func editingChanged(sender: AnyObject) {
        
        
        if ( Validator.emailExists(emailInput.text)) {
            
            continueButton.alpha = 1
            continueButton.enabled = true
            
        }
        else {
            continueButton.enabled = false
            continueButton.alpha = 0.4

        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Validator.requeryEmails()
        
        self.emailInput.delegate = self;
        continueButton.enabled = false
        continueButton.alpha = 0.4
        
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let vc = segue.destinationViewController as SecurityQuestionAnswerViewController
        
        vc.securityQuestions = UserDatabaseConnection.getSecQA(Encryptor.encrypt(emailInput.text))
        vc.usersEmail = emailInput.text
        
    }
    

}
