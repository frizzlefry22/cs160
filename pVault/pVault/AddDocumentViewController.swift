//
//  AddDocumentViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 11/29/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class AddDocumentViewController: UIViewController, UIPickerViewDelegate{
    
    var currentSelected : String!
    
    
    
    @IBOutlet weak var docTitle: UITextField!
    
    
    
    @IBAction func nextPushed(sender: AnyObject) {
        
        //Performs Segue based on the UIPicker Selecetd
        performSegueWithIdentifier( currentSelected , sender : sender)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if ( segue.identifier == DocType.CreditCard.rawValue ){
        
            let vc = segue.destinationViewController as CreditCardViewController
            
            vc.docTitle = docTitle.text
            
            //vc.delegate = self
            
        }
        

        
    }
    
    
    
    var doctype = [ DocType.None.rawValue, DocType.CreditCard.rawValue, DocType.Certificate.rawValue, DocType.License.rawValue, DocType.Other.rawValue]

    override func viewDidLoad() {
        super.viewDidLoad()

        //navigation
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
    
       return 1
    

    }

    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) ->Int {
        
        return doctype.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String {
        
        currentSelected = doctype[row]
        return doctype[row]
    }
}
