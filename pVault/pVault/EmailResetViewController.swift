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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let vc = segue.destinationViewController as SecurityQuestionAnswerViewController
        
    }
    

}
