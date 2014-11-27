//
//  ConfirmRegisterViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/24/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ConfirmRegisterViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextBox: UITextField!
    
    
    
    @IBAction func debugButtonForNow(sender: AnyObject) {
        
        RegisterInfo.createUser()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextBox.text = RegisterInfo.email
        emailTextBox.enabled = false
        
        
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
