//
//  InfiniteRepeatingScrollingNode.swift
//  FlappyBird
//
//  Created by Michael Gazzola on 10/19/14.
//  Copyright (c) 2014 Michael Gazzola. All rights reserved.
//

import SpriteKit
import UIKit

typealias SKScrollSpeed = UInt8

class InfiniteRepeatingScrollingNode: SKNode {
    convenience init(imageNamed: String, scrollSpeed: SKScrollSpeed, spriteHeight: CGFloat, screenWidth: CGFloat) {
        self.init()
        let spriteTexture = SKTexture(imageNamed: imageNamed)
        spriteTexture.filteringMode = .Nearest
        let spriteWidth = spriteTexture.size().width * GameConstants.spriteScale
        
        let moveSprite = SKAction.moveByX(-spriteWidth, y: 0,
                                          duration: NSTimeInterval((1.0 / CGFloat(scrollSpeed)) * spriteWidth))
        let resetSprite = SKAction.moveByX(spriteWidth, y: 0, duration: 0.0)
        let moveSpriteForever = SKAction.repeatActionForever(SKAction.sequence([moveSprite, resetSprite]))
        
        for (var i: CGFloat = 0.0; i < 2.0 + (screenWidth / spriteWidth); ++i) {
            let sprite = SKSpriteNode(texture: spriteTexture)
            sprite.setScale(GameConstants.spriteScale)
            sprite.position = CGPointMake(i * spriteWidth, sprite.size.height / 2.0 + spriteHeight)
            sprite.runAction(moveSpriteForever)
            self.addChild(sprite)
        }
    }
}
