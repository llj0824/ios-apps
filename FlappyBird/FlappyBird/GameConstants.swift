//
//  GameConstants.swift
//  FlappyBird
//
//  Created by Michael Gazzola on 10/19/14.
//  Copyright (c) 2014 Michael Gazzola. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


struct GameConstants {
    static let skyRed: CGFloat = 81.0 / 255.0
    static let skyGreen: CGFloat = 192.0 / 255.0
    static let skyBlue: CGFloat = 201.0 / 255.0
    static let skyAlpha: CGFloat = 1.0
    
    static let spriteScale: CGFloat = 2.0
    
    static let groundSpeed: SKScrollSpeed = 65
    static let skySpeed: SKScrollSpeed = 15
    
    static let birdFlapTime: NSTimeInterval = 0.2
    
    static let birdXRelativeToScreenWidth: CGFloat = 0.35
    static let birdYRelativeToScreenHeight: CGFloat = 0.60
    
    static let birdUpwardsTiltCoef: CGFloat = 0.001
    static let birdDownardsTiltCoef: CGFloat = 0.003
    static let birdMaxTilt: CGFloat = 0.5
    static let birdMinTilt: CGFloat = -1.0
    
    static let pipeGap: CGFloat = 250.0
}
