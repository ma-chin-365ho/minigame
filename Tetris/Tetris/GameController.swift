//
//  Controller.swift
//  Tetris
//
//  Created by 佐藤優成 on R 5/10/29.
//

import Foundation
import SpriteKit

class GameController {
    
    var shapes :[SKShapeNode] = []
    
    init(pos: CGPoint) {
        let btnRotationL = SKShapeNode(circleOfRadius: 10.0)
        btnRotationL.position = CGPoint(x: pos.x - 15, y: pos.y - 15)
        btnRotationL.strokeColor = SKColor.black
        btnRotationL.fillColor = SKColor.gray
        btnRotationL.name = "RotationLeft"

        let btnRotationR = SKShapeNode(circleOfRadius: 10.0)
        btnRotationR.position = CGPoint(x: pos.x + 15, y: pos.y - 15)
        btnRotationR.strokeColor = SKColor.black
        btnRotationR.fillColor = SKColor.gray
        btnRotationR.name = "RotationRight"
        
        
        /* 三角形かつ、rotateするとpositionやSKAction.moveByでの移動の際、おかしくなるので封印 */
        /*
        var pointsTriangle = [
            CGPoint(x: pos.x, y: pos.y + 30),
            CGPoint(x: pos.x - 15, y: pos.y),
            CGPoint(x: pos.x + 15, y: pos.y),
            CGPoint(x: pos.x, y: pos.y + 30)
        ]
        let btnMoveL = SKShapeNode(
            points: &pointsTriangle,
            count: pointsTriangle.count
        )
        btnMoveL.strokeColor = SKColor.black
        btnMoveL.fillColor = SKColor.gray
        btnMoveL.position = CGPoint(x: pos.x - 30, y: pos.y + 10)
        btnMoveL.run(
            SKAction.rotate(
                toAngle: GameUtils.degreeToRadian(degree :90.0),
                duration: 0
            )
        )
        btnMoveL.name = "MoveLeft"

        let btnMoveR = SKShapeNode(
            points: &pointsTriangle,
            count: pointsTriangle.count
        )
        btnMoveR.strokeColor = SKColor.black
        btnMoveR.fillColor = SKColor.gray
        btnMoveR.position = CGPoint(x: pos.x + 30 , y: pos.y + 10)
        btnMoveR.run(
            SKAction.rotate(
                toAngle: GameUtils.degreeToRadian(degree :270.0),
                duration: 0
            )
        )
        btnMoveR.run(
            SKAction.rotate(
                toAngle: GameUtils.degreeToRadian(degree :270.0),
                duration: 0
            )
        )
        btnMoveR.name = "MoveRight"
        
        let btnMoveU = SKShapeNode(
            points: &pointsTriangle,
            count: pointsTriangle.count
        )
        btnMoveU.strokeColor = SKColor.black
        btnMoveU.fillColor = SKColor.gray
        btnMoveU.position = CGPoint(x: pos.x, y: pos.y + 10)
        btnMoveU.run(
            SKAction.rotate(
                toAngle: GameUtils.degreeToRadian(degree :180.0),
                duration: 0
            )
        )
        btnMoveU.name = "MoveUnder"
        */

        let btnMoveL = SKShapeNode(circleOfRadius: 10.0)
        btnMoveL.position = CGPoint(x: pos.x - 30, y: pos.y + 10)
        btnMoveL.strokeColor = SKColor.black
        btnMoveL.fillColor = SKColor.gray
        btnMoveL.name = "MoveLeft"

        let btnMoveR = SKShapeNode(circleOfRadius: 10.0)
        btnMoveR.position = CGPoint(x: pos.x + 30 , y: pos.y + 10)
        btnMoveR.strokeColor = SKColor.black
        btnMoveR.fillColor = SKColor.gray
        btnMoveR.name = "MoveRight"

        let btnMoveU = SKShapeNode(circleOfRadius: 10.0)
        btnMoveU.position = CGPoint(x: pos.x, y: pos.y + 10)
        btnMoveU.strokeColor = SKColor.black
        btnMoveU.fillColor = SKColor.gray
        btnMoveU.name = "MoveUnder"

        self.shapes.append(contentsOf: [
            btnRotationL, btnRotationR,
            btnMoveL, btnMoveR, btnMoveU
        ])
    }
    
}
