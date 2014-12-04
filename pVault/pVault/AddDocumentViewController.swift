//
//  AddDocumentViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 11/29/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class AddDocumentViewController: UIViewController, UIPickerViewDelegate{
    
    var doctype = ["Credit Card", "Birth Certificate", "Driver License", "None", "Other"]

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String!{
        
        return doctype[row]
    }
}
