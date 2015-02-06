//
//  ViewController.swift
//  apple_development
//
//  Created by Leo Jiang on 9/24/14.
//  Copyright (c) 2014 Leo Jiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var createdItem: ScavengerHuntItem?
    var itemName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //what's UIStoryboardcanse
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DoneItem" {
            if let name = textField.text{
                if !name.isEmpty{
                    createdItem = ScavengerHuntItem(name: name)
                }
            }
        }
    }
    

}

