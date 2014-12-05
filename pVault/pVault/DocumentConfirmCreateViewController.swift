//
//  DocumentConfirmCreateViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 12/3/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class DocumentConfirmCreateViewController: UIViewController {

    
    
    var document : Document!
    
    @IBOutlet weak var docName: UITextField!
    
    @IBOutlet weak var imagePreview: UIImageView!
    
    
    @IBAction func createPushed(sender: AnyObject) {
        
        println("Debug")
        
        var pfOb = DocumentDBConnecion.createDocumentPFObject(self.document)
        DocumentDBConnecion.create(pfOb);
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        docName.text = document.docName
        
        imagePreview.image = Encoder.decodeImage(document.docImage)

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
