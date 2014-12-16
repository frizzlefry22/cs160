//
//  CurrentPassNewPassViewController.swift
//  pVault
//
//  Created by !Lashkar Singh on 12/12/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class CurrentPassNewPassViewController: UIViewController, UITextFieldDelegate  {

    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordWarningLabel: UILabel!;
    
    
    @IBAction func validatePass(sender: AnyObject)
    {
        if (passwordField.text == LoggedInuser.getPassword())
        {
            var changeConfirmPassViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChangeConfirmPassword")  as ConfirmNewPassViewController

            self.navigationController?.pushViewController(changeConfirmPassViewController, animated: true)
        }
        else
        {
            passwordWarningLabel.text = "Incorrect password"
        }
    }
    
    @IBAction func passwordEditChanged(sender: AnyObject)
    {
        if (passwordField.text.isEmpty)
        {
            passwordWarningLabel.text = "";
        }
    }
    
    @IBAction func cancel(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.passwordField.delegate = self;
        
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
    
    override func touchesBegan(touches: NSSet?, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
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


