//
//  CreditCardViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 11/30/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class CreditCardViewController: UIViewController {

    var docTitle : String!
    
    @IBOutlet weak var DocName: UITextField!
    
    
    @IBOutlet weak var cardHolderName: UITextField!
    
    @IBOutlet weak var creditCardNumber: UITextField!
    
    @IBOutlet weak var expirationDate: UITextField!
    
    @IBOutlet weak var cvc: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DocName.text = docTitle
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        
        
        
        // Pass the selected object to the new view controller.
    }


}
