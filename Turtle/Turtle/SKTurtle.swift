//
//  NodeTurtle.swift
//  Turtle
//
//  Created by 佐藤優成 on R 6/02/17.
//

import Foundation
import SpriteKit

let TURTLE_NODE_WIDTH : CGFloat = 30.0
let TURTLE_NODE_HEIGHT : CGFloat = 25.0

class SKTurtle : Turtle {
    
    var track : SKTrack?
    var angleDeg : CGFloat?
    var node : SKSpriteNode?
    var scene : SKScene?
    var trackLineWidth : CGFloat?
    
    init(scene: SKScene, startPos: CGPoint, startAngleDeg: CGFloat, trackLineWidth : CGFloat) {
        self.scene = scene
        self.trackLineWidth = trackLineWidth
        self.track = SKTrack(startPos: startPos, lineWidth: self.trackLineWidth!)
        self.node = SKSpriteNode(imageNamed: "turtle")
        self.node!.size = CGSize(width: TURTLE_NODE_WIDTH, height: TURTLE_NODE_HEIGHT)
        self.node!.position = startPos
        self.toAngle(degree : startAngleDeg)
        self.angleDeg = startAngleDeg
        
        self.scene?.addChild(self.track!.node!)
        self.scene?.addChild(self.node!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func mv(toPoint : CGPoint, isUpdateTrack : Bool) {
        let action = SKAction.move(to: toPoint, duration: 0.0)
        self.node!.run(action)
        if (isUpdateTrack) {
            self.track?.update(x: toPoint.x, y: toPoint.y)
        }
    }
    
    private func toAngle(degree : CGFloat) {
        self.angleDeg = degree
        let action = SKAction.rotate(toAngle: GameUtils.degreeToRadian(degree: self.angleDeg!), duration: 0.0)
        self.node!.run(action)
    }
    
    func forward(distance: Double, isUpdateTrack : Bool) {
        self.mv(
            toPoint :CGPoint(
                x: self.node!.position.x + (
                        CGFloat(distance) * cos(GameUtils.degreeToRadian(degree: self.angleDeg!))
                    ),
                y: self.node!.position.y + (
                        CGFloat(distance) * sin(GameUtils.degreeToRadian(degree: self.angleDeg!))
                    )
            ),
            isUpdateTrack: isUpdateTrack
        )
    }
    
    func warp(vec: Vec) {
        let toPoint = CGPoint(
            x: vec.x,
            y: vec.y
        )
        self.toAngle(degree: vec.angleDeg)
        self.mv(
            toPoint : toPoint,
            isUpdateTrack: false
        )
        self.track = SKTrack(startPos: toPoint, lineWidth: self.trackLineWidth!)
        self.scene?.addChild(self.track!.node!)
    }
    
    func rotate(direction : Direction, degree: Double) {
        var byAngleDeg : CGFloat?
        if (direction == .right) {
            byAngleDeg = degree * (-1)
        } else {
            byAngleDeg = degree
        }
        self.toAngle(degree: self.angleDeg! + byAngleDeg!)
    }
    
    func getVec() -> Vec {
        let vec = Vec(
            x:self.node!.position.x,
            y:self.node!.position.y,
            angleDeg: self.angleDeg!
        )
        return vec
    }
}
