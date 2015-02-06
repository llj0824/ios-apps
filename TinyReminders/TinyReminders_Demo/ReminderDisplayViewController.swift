//
//  ReminderDisplayViewController.swift
//  TinyReminders_Demo
//
//  Created by Michael Gazzola on 9/8/14.
//  Copyright (c) 2014 Michael Gazzola. All rights reserved.
//

import UIKit

class ReminderDisplayViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    var titleString: String = ""
    var dateString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = titleString
        self.dateLabel.text = dateString
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
