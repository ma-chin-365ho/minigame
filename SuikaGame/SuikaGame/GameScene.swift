//
//  GameScene.swift
//  SuikaGame
//
//  Created by 佐藤優成 on R 5/11/05.
//

import SpriteKit
import GameplayKit

let frameSizeX : CGFloat = 600 // 偶数
let frameSizeY : CGFloat = 600 // 偶数


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var nowFruits : Fruits?
    
    func genFruits() {
        let f = Fruits(
            pos: CGPoint(x: self.frame.midX, y: self.frame.midY + (frameSizeY / 2)),
            posOffsetType: "y_radius",
            stFruits: nil
        )
        self.addChild(f.shape!)
        self.nowFruits = f
    }

    func genFrameBorder() {
        let fb = SKShapeNode(rectOf: CGSize(width: frameSizeX, height: frameSizeY))
        fb.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        fb.name = "FrameBorder"
        fb.strokeColor = .white
        self.addChild(fb)
        
        /*
          NOTE:CGRectMake(長方形の左下頂点x座標,長方形の左下頂点y座標,長方形の縦幅,長方形の横幅)
         */
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRectMake(self.frame.midX - (frameSizeX / 2), self.frame.midY - (frameSizeY / 2), frameSizeX, frameSizeY))
    }
    
    func fallFruits() {
        self.nowFruits?.fall()
    }
    
    func combineFruits(nodeA: SKNode?, nodeB: SKNode?) {
        var f : Fruits? = nil
        if (nodeA != nil && nodeB != nil) {
            if (nodeA!.name == nodeB!.name) {
                self.removeChildren(in: [nodeA!, nodeB!])
                f = Fruits.combine(nodeA: nodeA!, nodeB: nodeB!, frame_range_x: getFrameRangeX(), frame_range_y: getFrameRangeY())
            }
        }
        if (f != nil) {
            self.addChild(f!.shape!)
        }
    }
    
    private func getFrameRangeX() -> ClosedRange<CGFloat> {
        return (self.frame.midX - (frameSizeX / 2))...(self.frame.midX + (frameSizeX / 2))
    }

    private func getFrameRangeY() -> ClosedRange<CGFloat> {
        return (self.frame.midY - (frameSizeY / 2))...(self.frame.midY + (frameSizeY / 2))
    }

    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        
        self.physicsWorld.contactDelegate = self
        
        self.genFruits()
        self.genFrameBorder()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        self.combineFruits(nodeA: contact.bodyA.node, nodeB: contact.bodyB.node)
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        self.nowFruits?.move(to_x: pos.x, frame_range_x: self.getFrameRangeX())
    }
    
    func touchUp(atPoint pos : CGPoint) {
        self.fallFruits()
        self.genFruits()
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
        
        self.lastUpdateTime = currentTime
    }
}
