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
    
    init(startPos: CGPoint, startAngleDeg: CGFloat) {
        self.track = SKTrack(startPos: startPos)
        self.node = SKSpriteNode(imageNamed: "turtle")
        self.node!.size = CGSize(width: TURTLE_NODE_WIDTH, height: TURTLE_NODE_HEIGHT)
        self.node!.position = startPos
        self.toAngle(degree : startAngleDeg)
        self.angleDeg = startAngleDeg
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
    
    func forward(distance: Double) {
        self.mv(
            toPoint :CGPoint(
                x: self.node!.position.x + (
                        CGFloat(distance) * cos(GameUtils.degreeToRadian(degree: self.angleDeg!))
                    ),
                y: self.node!.position.y + (
                        CGFloat(distance) * sin(GameUtils.degreeToRadian(degree: self.angleDeg!))
                    )
            ),
            isUpdateTrack: true
        )
    }
    
    func warp(vec: Vec) {
        self.toAngle(degree: vec.angleRad)
        self.mv(
            toPoint :CGPoint(
                x: vec.x,
                y: vec.y
            ),
            isUpdateTrack: false
        )
    }
    
    func rotate(direction : Direction, degree: Double) {
        var byAngleDeg : CGFloat?
        if (direction == .right) {
            byAngleDeg = degree
        } else {
            byAngleDeg = degree * (-1)
        }
        self.toAngle(degree: self.angleDeg! + byAngleDeg!)
    }
    
    func getVec() -> Vec {
        let vec = Vec(
            x:self.node!.position.x,
            y:self.node!.position.y,
            angleRad: GameUtils.degreeToRadian(degree: self.angleDeg!)
        )
        return vec
    }
}
