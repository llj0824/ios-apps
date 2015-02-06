//
//  GameScene.swift
//  FlappyBird
//
//  Created by Nate Murray on 6/2/14.
//  Copyright (c) 2014 Fullstack.io. All rights reserved.
//

import SpriteKit

// Extension of the sky color. ;)
extension SKColor {
    class func skyColor() -> SKColor {
        return SKColor(red: GameConstants.skyRed,
                       green: GameConstants.skyGreen,
                       blue: GameConstants.skyBlue,
                       alpha: GameConstants.skyAlpha)
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {

    var bird: SKSpriteNode!  // Control the bird.
    var moving: SKNode!      // Control all moving objects.
    var pipes: SKNode!       // Keep track of our pipes.
    var canRestart: Bool = true
    var score: UInt = 0
    var scoreLabelNode: SKLabelNode!
    
    let birdCategory: UInt32 = 1 << 0
    let worldCategory: UInt32 = 1 << 1
    let pipeCategory: UInt32 = 1 << 2
    let scoreCategory: UInt32 = 1 << 3
    
    override func didMoveToView(view: SKView) {
        
        // Set up the world.
        self.physicsWorld.gravity = CGVectorMake(0.0, -10.0)
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor.skyColor()
        
        // Set up our background: moving platform and sky backdrop.
        self.moving = SKNode()
        let landScroller = InfiniteRepeatingScrollingNode(
                imageNamed: "land", scrollSpeed: GameConstants.groundSpeed,
                spriteHeight: 0, screenWidth: self.frame.size.width)
        let landTextureHeight = (landScroller.children[0] as SKSpriteNode).size.height
        let skyScroller = InfiniteRepeatingScrollingNode(
                imageNamed: "sky", scrollSpeed: GameConstants.skySpeed,
                spriteHeight: landTextureHeight, screenWidth: self.frame.size.width)
        skyScroller.zPosition = -2
        self.moving.addChild(landScroller)
        self.moving.addChild(skyScroller)
        
        // Set up our bird.
        // Textures and animations.
        let birdTexture1 = SKTexture(imageNamed: "bird-01")
        let birdTexture2 = SKTexture(imageNamed: "bird-02")
        birdTexture1.filteringMode = .Nearest
        birdTexture2.filteringMode = .Nearest
        let flapForever = SKAction.repeatActionForever(SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame: GameConstants.birdFlapTime))
        self.bird = SKSpriteNode(texture: birdTexture1)
        self.bird.setScale(GameConstants.spriteScale)
        self.bird.position = CGPoint(x: self.frame.size.width * GameConstants.birdXRelativeToScreenWidth, y: self.frame.size.height * GameConstants.birdYRelativeToScreenHeight)
        self.bird.runAction(flapForever)
        
        // Bird physics.
        self.bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2.0)
        self.bird.physicsBody?.dynamic = true
        self.bird.physicsBody?.allowsRotation = false
        self.bird.physicsBody?.categoryBitMask = self.birdCategory
        self.bird.physicsBody?.collisionBitMask = self.worldCategory | self.pipeCategory
        self.bird.physicsBody?.contactTestBitMask = self.worldCategory | self.pipeCategory
        
        // Set up our ground physics.
        let ground = SKNode()
        ground.position = CGPointMake(0, landTextureHeight / 2.0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, landTextureHeight))
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = self.worldCategory
        
        // Pipes, texture and animations.
        self.pipes = SKNode()
        let pipeTextureBottom = SKTexture(imageNamed: "PipeUp")
        let pipeTextureTop = SKTexture(imageNamed: "PipeDown")
        pipeTextureBottom.filteringMode = .Nearest
        pipeTextureTop.filteringMode = .Nearest
        
        let distanceToMove = CGFloat(self.frame.size.width + 2.0 * pipeTextureBottom.size().width)
        let movePipes = SKAction.moveByX(-distanceToMove, y:0.0, duration: NSTimeInterval(0.01 * distanceToMove))
        let removePipes = SKAction.removeFromParent()
        let movePipesAndRemove = SKAction.sequence([movePipes, removePipes])
        
        let spawn = SKAction.runBlock { () -> Void in
            self.spawnPipes(bottom: pipeTextureBottom, top: pipeTextureTop, animation: movePipesAndRemove)
        }
        let delay = SKAction.waitForDuration(NSTimeInterval(2.0))
        let spawnThenDelay = SKAction.sequence([spawn, delay])
        self.runAction(SKAction.repeatActionForever(spawnThenDelay))
        self.moving.addChild(self.pipes)
        
        self.scoreLabelNode = SKLabelNode(fontNamed:"MarkerFelt-Wide")
        self.scoreLabelNode.position = CGPointMake(CGRectGetMidX(self.frame),
                                                   3 * self.frame.size.height / 4)
        self.scoreLabelNode.zPosition = 1
        self.scoreLabelNode.text = String(self.score)
        
        self.addChild(self.moving)
        self.addChild(self.bird)
        self.addChild(ground)
        self.addChild(self.scoreLabelNode)
    }
    
    func spawnPipes(#bottom: SKTexture, top: SKTexture, animation: SKAction) {
        let pipePair = SKNode()
        pipePair.zPosition = -1
        pipePair.position = CGPointMake(self.frame.size.width + bottom.size().width * 2, 0)
        let maxHeight = UInt32(self.frame.size.height / 4)
        let bottomHeight = arc4random() % maxHeight + maxHeight
        
        let bottomPipe = SKSpriteNode(texture: bottom)
        bottomPipe.setScale(GameConstants.spriteScale)
        bottomPipe.position = CGPointMake(0.0, CGFloat(bottomHeight))
        bottomPipe.physicsBody = SKPhysicsBody(rectangleOfSize: bottomPipe.size)
        bottomPipe.physicsBody?.dynamic = false
        bottomPipe.physicsBody?.categoryBitMask = self.pipeCategory
        
        let topPipe = SKSpriteNode(texture: top)
        topPipe.setScale(GameConstants.spriteScale)
        topPipe.position = CGPointMake(0.0, CGFloat(bottomHeight) + topPipe.size.height + GameConstants.pipeGap)
        topPipe.physicsBody = SKPhysicsBody(rectangleOfSize: topPipe.size)
        topPipe.physicsBody?.dynamic = false
        topPipe.physicsBody?.categoryBitMask = self.pipeCategory
        
        let scoreContact = SKNode()
        scoreContact.position = CGPointMake(topPipe.size.width + self.bird.size.width / 2, CGRectGetMidY(self.frame))
        scoreContact.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(bottomPipe.size.width, self.frame.size.height))
        scoreContact.physicsBody?.dynamic = false
        scoreContact.physicsBody?.categoryBitMask = self.scoreCategory
        scoreContact.physicsBody?.contactTestBitMask = self.birdCategory
        
        pipePair.addChild(bottomPipe)
        pipePair.addChild(topPipe)
        pipePair.addChild(scoreContact)
        
        pipePair.runAction(animation)
        self.pipes.addChild(pipePair)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if (self.moving.speed == 1) {
            self.bird.physicsBody?.velocity = CGVectorMake(0, 0)
            self.bird.physicsBody?.applyImpulse(CGVectorMake(0, 40))
        } else if self.canRestart {
            self.restart()
        }
    }
    
    func restart() {
        self.bird.position = CGPoint(x: self.frame.size.width * GameConstants.birdXRelativeToScreenWidth, y: self.frame.size.height * GameConstants.birdYRelativeToScreenHeight)
        self.bird.physicsBody?.velocity = CGVectorMake(0,0)
        self.bird.physicsBody?.collisionBitMask = self.worldCategory | self.pipeCategory
        self.bird.speed = 1.0
        self.bird.zRotation = 0.0
        
        self.pipes.removeAllChildren()
        
        self.score = 0
        self.scoreLabelNode.text = String(self.score)
        
        self.canRestart = false
        self.moving.speed = 1
    }
    
    override func update(currentTime: NSTimeInterval) {
        let dy = self.bird.physicsBody!.velocity.dy
        if (dy < 0) {
            self.bird.zRotation = max(GameConstants.birdMinTilt, self.bird.physicsBody!.velocity.dy * GameConstants.birdDownardsTiltCoef)
        } else {
            self.bird.zRotation = min(GameConstants.birdMaxTilt, self.bird.physicsBody!.velocity.dy * GameConstants.birdUpwardsTiltCoef)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (self.moving.speed == 1) {
            if (contact.bodyA.categoryBitMask & (self.worldCategory | self.pipeCategory) != 0 ||
                contact.bodyB.categoryBitMask & (self.worldCategory | self.pipeCategory) != 0) {
                self.moving.speed = 0
                self.bird.physicsBody?.collisionBitMask = self.worldCategory  // What will this do?
                self.bird.speed = 0
                self.runAction(SKAction.sequence([SKAction.repeatAction(SKAction.sequence([SKAction.runBlock({
                    self.backgroundColor = SKColor(red: 1, green: 0, blue: 0, alpha: 1.0)
                }),SKAction.waitForDuration(NSTimeInterval(0.05)), SKAction.runBlock({
                    self.backgroundColor = SKColor.skyColor()
                }), SKAction.waitForDuration(NSTimeInterval(0.05))]), count:4), SKAction.runBlock({
                    self.canRestart = true
                })]), withKey: "flashRed")
            } else {
                self.score++
                self.scoreLabelNode.text = String(self.score)
                self.runAction(SKAction.sequence([SKAction.repeatAction(SKAction.sequence([SKAction.runBlock({
                    self.backgroundColor = SKColor(red: 0, green: 1, blue: 0, alpha: 1.0)
                }),SKAction.waitForDuration(NSTimeInterval(0.05)), SKAction.runBlock({
                    self.backgroundColor = SKColor.skyColor()
                }), SKAction.waitForDuration(NSTimeInterval(0.05))]), count:4)]), withKey: "flashGreen")
            }
        }
    }

}
