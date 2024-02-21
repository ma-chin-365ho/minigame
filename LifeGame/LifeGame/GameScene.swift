//
//  GameScene.swift
//  LifeGame
//
//  Created by 佐藤優成 on R 6/02/05.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()

    private var lastUpdateTime : TimeInterval = 0
    private var life : SKLife?
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        
        self.life = SKLife(frameX: self.frame.midX, frameY: self.frame.midY)
                
        for cellNodesY in self.life!.cellNodes! {
            for cellNode in cellNodesY {
                self.addChild(cellNode!)
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        // self.life?.toggle(pos: pos)
        self.life?.setPattern(pos: pos, cellsPattern: CellsPattern.Glider)
        self.life?.draw()
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        self.life?.toLife(pos: pos)
        self.life?.draw()
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 49: // Space
            self.life?.next()
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        // self.life?.next()
        self.lastUpdateTime = currentTime
    }
}
