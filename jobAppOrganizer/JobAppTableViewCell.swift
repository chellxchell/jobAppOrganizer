//
//  JobAppTableViewCell.swift
//  jobAppOrganizer
//
//  Created by Medill on 11/1/19.
//  Copyright © 2019 Medill. All rights reserved.
// INDIVIDUAL CELLS IN JOB APPLICATION TABLE

import UIKit

class JobAppTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
