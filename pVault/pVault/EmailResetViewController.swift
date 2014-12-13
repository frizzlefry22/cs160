//
//  EmailResetViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 12/10/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class EmailResetViewController: UIViewController {

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

        continueButton.enabled = false
        continueButton.alpha = 0.4
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let vc = segue.destinationViewController as SecurityQuestionAnswerViewController
        
        vc.securityQuestions = UserDatabaseConnection.getSecQA(emailInput.text)
        
    }
    

}
