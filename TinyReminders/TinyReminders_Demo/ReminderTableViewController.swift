//
//  ReminderTableViewController.swift
//  TinyReminders_Demo
//
//  Created by Michael Gazzola on 9/8/14.
//  Copyright (c) 2014 Michael Gazzola. All rights reserved.
//

import UIKit

struct Reminder {
    var title: String
    var timestamp: String
}

class ReminderTableViewController: UITableViewController, UITableViewDataSource {
    
    var reminders: [Reminder] = [
        Reminder(title:"Call mom", timestamp:"eventually"),
        Reminder(title:"Call sister", timestamp:"never"),
    ]
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reminder") as? ReminderCellTableViewCell ?? ReminderCellTableViewCell()
        var reminder = self.reminders[indexPath.row]
        cell.reminderTitle.text = reminder.title
        cell.reminderDate.text = reminder.timestamp
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("reminders.count = \(self.reminders.count)")
        return self.reminders.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case "tableToDisplay":
            if var secondViewController = segue.destinationViewController as? ReminderDisplayViewController {
                if var cell = sender as? ReminderCellTableViewCell {
                    secondViewController.titleString = cell.reminderTitle.text!
                    secondViewController.dateString = cell.reminderDate.text!
                }
            }
        default:
            break
        }
    }
    @IBAction func done(segue: UIStoryboardSegue){
        println("what")
    }


}
