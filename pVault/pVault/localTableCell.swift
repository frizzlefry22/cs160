//
//  localTableCell.swift
//  pVault
//
//  Created by Kevin Tran on 12/14/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class localTableCell: UITableViewCell {

    @IBOutlet weak var docName: UILabel!
    
    @IBOutlet weak var docType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(nameLabel: String, typeLabel: String)
    {
        self.docName.text = nameLabel
        self.docType.text = typeLabel
    }


}
