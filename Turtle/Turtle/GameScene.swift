//
//  GameScene.swift
//  Turtle
//
//  Created by 佐藤優成 on R 6/02/17.
//

import SpriteKit
import GameplayKit

enum KeyCode: UInt16 {
    case space = 49
    case n = 45
}

enum GameStatus {
    case play
    case stop
    case skip
    case skiping
}

class GameScene: SKScene {
    
    var turtle :Turtle?
    var turtleController : TurtleController?
    // var drawIntervalSec : TimeInterval = 0.15
    var drawIntervalSec : TimeInterval = 0.0
    var oldTime : TimeInterval? = nil
    var status : GameStatus = .stop
    var rewriteCount : Int = 6
    
    override func didMove(to view: SKView) {
        self.setLSystem(lSystem: PENROSE_TILES)
    }
    
    func setLSystem(lSystem : LSystem) {
        self.turtle = SKTurtle(
            scene: self,
            startPos: CGPoint(x: lSystem.startX, y: lSystem.startY),
            startAngleDeg: lSystem.startAngleDeg,
            trackLineWidth: lSystem.trackLineWidth
        )
        self.turtleController = TurtleController(turtle: self.turtle!)
        
        let cmd = LSystemUtil.rewrite(
            startCmd: lSystem.startCmd,
            rewirteRule: lSystem.rewirteRule,
            count: self.rewriteCount
        )
        print(cmd)
        try? self.turtleController?.readCmd(cmd: cmd)
        self.turtleController?.setConfig(
            forwardDistance: lSystem.forwardDistance,
            rotationDeg: lSystem.rotationDeg
        )
    }
    
    func isAccepted() -> Bool {
        if (self.status == .skip || self.status == .skiping) {
            return false
        } else {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if (self.isAccepted()) {
            if (self.status == .play) {
                self.status = .stop
            } else {
                self.status = .play
            }
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
        if (self.isAccepted()) {
            switch event.keyCode {
            case KeyCode.space.rawValue:
                self.status = .skip
            case KeyCode.n.rawValue:
                self.turtleController?.next()
            default:
                print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if (self.oldTime == nil) {
            self.oldTime = currentTime
        }
        if (self.status == .play) {
            if (currentTime - self.oldTime! > self.drawIntervalSec) {
                self.turtleController?.next()
                self.oldTime = currentTime
            }
        } else if (self.status == .skip) {
            self.status = .skiping
            self.turtleController?.skip()
        }
    }
}
