//
//  Player.swift
//  gestures
//
//  Created by Leo Jiang on 9/22/14.
//  Copyright (c) 2014 Leo Jiang. All rights reserved.
//

import UIKit
//The model
class Player: NSObject {
    var name: String
    var score: Int
    
    init(name: String) {
        self.name = name
        self.score = 0
    }
}
