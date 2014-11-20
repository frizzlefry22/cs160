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
    
    @IBAction func emailEdited(sender: UITextField) {
        
        
        if (emailExists(email.text)) {
            continueButton.enabled = true
            email.textColor = UIColor.greenColor()
        }
        else {
            email.textColor = UIColor.redColor()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
