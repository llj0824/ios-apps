//
//  FirstViewController.swift
//  gestures
//
//  Created by Leo Jiang on 9/22/14.
//  Copyright (c) 2014 Leo Jiang. All rights reserved.
//

import UIKit

protocol NewPlayerDelegate {
    func receivedNewPlayer(name: String)
}

class FirstViewController: UIViewController, NewPlayerDelegate {

    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var gestureLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var gameView: UIImageView!
    
    @IBOutlet var startButton: UIButton!
    
    var currentPlayer: Player!
    
    var tap: UITapGestureRecognizer!
    var pinch: UIPinchGestureRecognizer!
    var longPress: UILongPressGestureRecognizer!
    var rotate: UIRotationGestureRecognizer!
    var pan: UIPanGestureRecognizer!
    var swipe: UISwipeGestureRecognizer!
    
    func setup() {
        self.gameView.addGestureRecognizer(self.pinch)
        self.gameView.addGestureRecognizer(self.tap)
        self.tap.addTarget(self, action: "tapped:")
        self.pinch.addTarget(self, action: "pinched:")
    }
    
    func tapped(sender: UIGestureRecongizer) {
        println("this gets printed when button pressed")
    }
    
    func pinched(sener: UIGestureRecognizer){
        sender.view!.transform = CGAffineTransformScle(sender.view!.transform,sender.scale,sender.scale)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tap = UITapGestureRecognizer()
        self.pinch = UIPinchGestureRecognizer()
        self.longPress = UILongPressGestureRecognizer()
        self.rotate = UIRotationGestureRecognizer()
        self.pan = UIPanGestureRecognizer()
        self.nameLabel.text = self.currentPlayer.name
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func receivedNewPlayer(name: String) {
        self.currentPlayer = Player(name: name)
        self.nameLabel.text = name
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var newPlayer = segue.destinationViewController as? NewPlayerViewController
        newPlayer?.delegate = self
    }

}

