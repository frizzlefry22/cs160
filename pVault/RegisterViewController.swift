//
//  RegisterViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/18/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var email: UITextField!

    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBAction func emailEdited(sender: UITextField) {
        
        if (!Validator.emailExists(email.text) && Validator.emailValid(email.text)) {
            continueButton.enabled = true
            warningLabel.text = "Available"
            warningLabel.textColor = UIColor.greenColor()
            //Makes the button fully blue again
            continueButton.alpha = 1
        }
        else if (Validator.emailExists(email.text))
        {
            warningLabel.text = "Email exists"
            warningLabel.textColor = UIColor.redColor()
            continueButton.enabled = false
            continueButton.alpha = 0.4
        }
        else {
            
            warningLabel.text = "Invalid email"
            warningLabel.textColor = UIColor.redColor()
            continueButton.enabled = false
            continueButton.alpha = 0.4
        }
    }
    
    //Called before it goes to next Screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Sets the email everytime this page advances
        RegisterInfo.email = email.text!
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This makes the button look unclickable
        continueButton.alpha = 0.4
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
