//
//  NewPlayerViewController.swift
//  gestures
//
//  Created by Leo Jiang on 9/22/14.
//  Copyright (c) 2014 Leo Jiang. All rights reserved.
//

import UIKit

class NewPlayerViewController: FirstViewController {
    
    var delegate: NewPlayerDelegate!

    @IBOutlet var nameTextField: UITextField!
    
    @IBAction func pressedOutsideKeyboard(sender: AnyObject) {
        self.nameTextField.resignFirstResponder()
    }

    @IBAction func doneButton(sender: UIButton) {
        self.nameTextField.endEditing(true)
        delegate.receivedNewPlayer(nameTextField.text!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
