//
//  GameScene.swift
//  Turtle
//
//  Created by 佐藤優成 on R 6/02/17.
//

import SpriteKit
import GameplayKit

enum GameStatus {
    case play
    case stop
}

class GameScene: SKScene {
    
    var track : SKTrack?
    var turtle :SKTurtle?
    var turtleController : TurtleController?
    var drawIntervalSec : TimeInterval = 0.15
    var oldTime : TimeInterval? = nil
    var status : GameStatus = .stop
    
    override func didMove(to view: SKView) {
        let startPos = CGPoint(x: -350.0, y: -250.0)
        let startAngleDeg = 0.0
        
        self.turtle = SKTurtle(startPos: startPos, startAngleDeg: startAngleDeg)
        self.turtleController = TurtleController(turtle: self.turtle!)
        
        try? self.turtleController?.readCmd(cmd: "F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F-F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F-F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F")
        self.turtleController?.setConfig(forwardDistance: 30.0, rotationDeg: 60.0)

        self.addChild(self.turtle!.track!.node!)
        self.addChild(self.turtle!.node!)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        self.status = .play
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
        switch event.keyCode {
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
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
        }
    }
}
