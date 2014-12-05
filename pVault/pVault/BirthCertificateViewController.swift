//
//  BirthCertificateViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 11/30/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class BirthCertificateViewController: UIViewController, DocumentView {

    var document : Document!
    
    @IBOutlet weak var certName: UITextField!
    @IBOutlet weak var certDOB: UITextField!
    @IBOutlet weak var certPOB: UITextField!
    @IBOutlet weak var certParentsName: UITextField!
    @IBOutlet weak var certNumber: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var fieldDictionary = [String:String]()
        
        fieldDictionary["CertificateName"] = certName.text
        fieldDictionary["Date of Birth"] = certDOB.text
        fieldDictionary["Place of Birth"] = certDOB.text
        fieldDictionary["Parents Name"] = certParentsName.text
        fieldDictionary["Number"] = certNumber.text
        
        document.docField = fieldDictionary
        
        let vc = segue.destinationViewController as DocPhotoViewController
        
        vc.document = document
        
    }


}
