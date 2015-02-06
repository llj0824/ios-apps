//
//  ReminderCellTableViewCell.swift
//  TinyReminders_Demo
//
//  Created by Michael Gazzola on 9/8/14.
//  Copyright (c) 2014 Michael Gazzola. All rights reserved.
//

import UIKit

class ReminderCellTableViewCell: UITableViewCell {

    @IBOutlet var reminderTitle: UILabel!
    @IBOutlet var reminderDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
