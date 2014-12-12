//
//  ViewDocumentViewController.swift
//  pVault
//
//  Created by Kevin Tran on 12/11/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ViewDocumentViewController: UIViewController {
    
    var objectId: String!
    var document: Document!
    
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        document = DocumentDBConnection.read(DocumentDBConnection.readObject(objectId)) as Document
        
        testLabel.text = document.docName
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
