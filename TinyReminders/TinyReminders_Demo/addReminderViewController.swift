//
//  addReminderViewController.swift
//  TinyReminders_Demo
//
//  Created by Leo Jiang on 9/29/14.
//  Copyright (c) 2014 Michael Gazzola. All rights reserved.
//

import Foundation
import UIKit


class addReminderViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var labelTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var Done: UIButton!
    
    func addReminder()->Reminder{
        var newReminder = Reminder(title: labelTextField.text, timestamp: timeTextField.text)
        return newReminder
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "addReminder" {
            var homeViewController = segue.destinationViewController as? ReminderTableViewController
            var cell = addReminder()
            homeViewController?.reminders.append(cell)
//        }
        
    }
    
    

    
    /*
    1. function to put textfields into tableviewCell obj
    2. prepare for segue: add tableviewcell to reminders array
    3. dismiss view to go back to tinyReminders
    */
    
    
    
    
}