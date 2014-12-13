//
//  HistoryTableViewController.swift
//  pVault
//
//  Created by Kevin Tran on 12/12/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class HistoryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DocumentView{

    var selectedItem: String!
    
    //DocumentView protocol 
    var document: Document!
    
    var hisList:[(objectID: String, docName: String)] = []
    
    //for search
    
    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        hisList = DocumentDBConnection.getHistory(document.objectID)
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
        return hisList.count
    }
    
    //creates the cells with documnet name and doc type
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("hisCell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        
        var doc = hisList[indexPath.row]
        cell.textLabel.text = doc.docName
        
        return cell
    }
    
    //when cell is selected, it'll more to the view document nib and takes the object id with it
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //object id that will be used to read document
        selectedItem = hisList[indexPath.row].objectID
        self.performSegueWithIdentifier("viewHistory", sender: self)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        //sets the object id of ViewDocumentViewController
        var vc = segue.destinationViewController as ViewHisDocViewController
        vc.objectId = selectedItem
    }

}
