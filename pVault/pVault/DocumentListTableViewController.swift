//
//  DocumentListTableViewController.swift
//  pVault
//
//  Created by Kevin Tran on 11/30/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class DocumentListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var selectedItem: String!
    
    var selectedDocument: Document!

    var docList:[(objectID: String, docName: String, docType: String)] = []
    
    //for search
    //var filteredDocList:[(objectID: String, docName: String, docType: String)] = []
    
    @IBOutlet weak var docTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        docList = DocumentDBConnection.getDocList("test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    //returns number of rows which are number of documents
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return docList.count
    }

    //creates the cells with documnet name and doc type
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("docCell", forIndexPath: indexPath) as docListCell

        // Configure the cell...
        
        var doc = docList[indexPath.row]
        cell.setCell(doc.docName, typeLabel: doc.docType)

        return cell
    }

    //when cell is selected, it'll more to the view document nib and takes the object id with it
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //object id that will be used to read document
        selectedItem = docList[indexPath.row].objectID
        selectedDocument = DocumentDBConnection.read(DocumentDBConnection.readObject(selectedItem)) as Document
        //asked to enter your pin
        let alertController = UIAlertController(title: "Enter Your", message: "4-digit pin", preferredStyle: .Alert)
        
        //add cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            println(action)
        }
        alertController.addAction(cancelAction)
        
        //add textfield
        alertController.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "1234"
                textField.secureTextEntry = true;
                textField.keyboardType = UIKeyboardType.NumberPad

        })
        //textfield for the pin
        let pinAction = UIAlertAction(title: "Next",
            style: UIAlertActionStyle.Default,
            handler: {(action) in
                
                if let textFields = alertController.textFields{
                    let theTextFields = textFields as [UITextField]
                    let pin = theTextFields[0].text
                    
                    //if correct pin; view document
                    if(Validator.matches(pin, s2: LoggedInuser.getPIN())){
                        self.performSegueWithIdentifier("ViewDoc", sender: self)
                    }
                    //wrong pin
                    else{
                        let alertController = UIAlertController(title: "Incorrect Pin", message: "Try again", preferredStyle: .Alert)
                        
                        let okAction = UIAlertAction(title: "Ok", style: .Default) {
                            (action) in
                        }
                        
                        alertController.addAction(okAction)
                        self.presentViewController(alertController,animated:true) {}
                    }
                }
            })
        alertController.addAction(pinAction)
        self.presentViewController(alertController,animated:true) {}
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        //sets the object id of ViewDocumentViewController
        var vc = segue.destinationViewController as ViewDocumentViewController
        vc.document = self.selectedDocument
    }
    
}
