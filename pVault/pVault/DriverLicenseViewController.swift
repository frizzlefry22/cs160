//
//  DriverLicenseViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 11/30/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class DriverLicenseViewController: UIViewController, DocumentView {

    @IBOutlet weak var licenseName: UITextField!
    
    @IBOutlet weak var licenseDOB: UITextField!
    
    @IBOutlet weak var licenseNum: UITextField!
    
    @IBOutlet weak var licenseExp: UITextField!
    
    @IBOutlet weak var licenseClass: UITextField!
    
    @IBOutlet weak var licenseAddress: UITextView!
    
    var document : Document!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
