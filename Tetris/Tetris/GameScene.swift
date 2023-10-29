//
//  GameScene.swift
//  Tetris
//
//  Created by 佐藤優成 on R 5/10/28.
//

// FIXME: SwiftとSpritKitのバージョンをReadmeに書いておく。

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var lastRectTime : TimeInterval = 0
    private var nowBlock : Tetromino?
    private var stackMinos : [SKShapeNode] = []
    
    func genTetromino() {
        let t = BlockT(pos : CGPoint(x:self.frame.midX, y:self.frame.midY + (((cellSize * yCellCount) / 2) + cellSize / 2)))
        for mino in t.minos {
            self.addChild(mino)
        }
        self.nowBlock = t
    }
    
    func genGameController() {
        let gc = GameController(pos : CGPoint( x: self.frame.midX + 400, y: self.frame.midY - 300))
        for shape in gc.shapes {
            self.addChild(shape)
        }
    }
    
    func genFrameBorder() {
        let fb = SKShapeNode(rectOf: CGSize(width: cellSize * xCellCount, height: cellSize * yCellCount))
        fb.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        fb.strokeColor = .white
        self.addChild(fb)
    }
        
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        
        self.genFrameBorder()
        self.genGameController()
        self.genTetromino()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        let node = self.atPoint(pos)
        
        if (node.name == "MoveLeft") {
            self.nowBlock?.move(direction : "l", centerPos: CGPoint(x: self.frame.midX, y: self.frame.midY), stackMinos: self.stackMinos)
        } else if (node.name == "MoveRight") {
            self.nowBlock?.move(direction : "r", centerPos: CGPoint(x: self.frame.midX, y: self.frame.midY), stackMinos: self.stackMinos)
        } else if (node.name == "MoveUnder") {
            self.nowBlock?.move(direction : "u", centerPos: CGPoint(x: self.frame.midX, y: self.frame.midY), stackMinos: self.stackMinos)
        } else if (node.name == "RotationLeft") {
            self.nowBlock?.rotate(direction : "l", centerPos: CGPoint(x: self.frame.midX, y: self.frame.midY), stackMinos: self.stackMinos)
        } else if (node.name == "RotationRight") {
            self.nowBlock?.rotate(direction : "r", centerPos: CGPoint(x: self.frame.midX, y: self.frame.midY), stackMinos: self.stackMinos)
        }
    }
        
    func touchMoved(toPoint pos : CGPoint) {
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

        if (self.lastRectTime + 0.7 <= currentTime) {
            if (self.nowBlock?.isHarden(centerPos: CGPoint(x: self.frame.midX, y: self.frame.midY), stackMinos: self.stackMinos) == true) {
                self.stackMinos.append(contentsOf: self.nowBlock!.minos)
                self.genTetromino()
            } else {
                self.nowBlock?.move(direction : "u", centerPos: CGPoint(x: self.frame.midX, y: self.frame.midY), stackMinos: self.stackMinos)
            }
            self.lastRectTime = currentTime
        }

        self.lastUpdateTime = currentTime
    }
}
