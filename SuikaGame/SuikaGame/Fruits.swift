//
//  Fruits.swift
//  SuikaGame
//
//  Created by 佐藤優成 on R 5/11/05.
//

import SpriteKit
import Foundation
import SwiftUI

let fruitsTypes : [StFruits] = [
    StFruits(name_radius: "sakuranbo:20", color: .red),
    StFruits(name_radius: "banana:50",color: .yellow),
    StFruits(name_radius: "kiui:100",color: .brown),
    StFruits(name_radius: "suika:150" ,color: .green)
]

struct StFruits {
    var name_radius : String;
    var color : NSColor;
}

class Fruits {
    
    var shape :SKShapeNode?
    var radius: CGFloat?
        
    init(pos: CGPoint, posOffsetType: String, stFruits: StFruits?) {
        let fruitsType = stFruits ?? fruitsTypes.randomElement()
        self.radius = CGFloat(Fruits.getRadiusFromName(name: fruitsType!.name_radius))

        let circle = SKShapeNode(circleOfRadius: self.radius!)
        var offsetY: CGFloat = 0.0
        
        if (posOffsetType == "y_radius") {
            offsetY = self.radius! * (-1)
        }
        circle.name = fruitsType!.name_radius
        circle.position = CGPointMake(pos.x, pos.y + offsetY)
        circle.fillColor = fruitsType!.color

        self.shape = circle
    }
    
    static func getRadiusFromName(name: String) -> Int {
        return Int(name.components(separatedBy: ":")[1])!
    }
    
    static func combine(nodeA: SKNode, nodeB: SKNode, frame_range_x: ClosedRange<CGFloat>, frame_range_y: ClosedRange<CGFloat>) -> Fruits? {
        var fruits : Fruits? = nil
        let radius = Fruits.getRadiusFromName(name : nodeA.name!)
        
        var fruitsTypeRadius = 0
        for fruitsType in fruitsTypes {
            fruitsTypeRadius = Fruits.getRadiusFromName(name : fruitsType.name_radius)
            if (fruitsTypeRadius > radius) {
                fruits = Fruits(
                    pos : CGPoint(
                        x: GameUtils.keepCircleCenterInRange(center: (nodeA.position.x + nodeB.position.x) / 2, range: frame_range_x, radius: CGFloat(fruitsTypeRadius)),
                        y: GameUtils.keepCircleCenterInRange(center: (nodeA.position.y + nodeB.position.y) / 2, range: frame_range_y, radius: CGFloat(fruitsTypeRadius))
                    ),
                    posOffsetType: "",
                    stFruits:fruitsType
                )
                fruits!.fall()
                break
            }
        }
        return fruits
    }

    func fall() {
        self.shape!.physicsBody = SKPhysicsBody(circleOfRadius: self.radius!)
        self.shape!.physicsBody!.categoryBitMask = 0b000001
        self.shape!.physicsBody!.contactTestBitMask = 0b000001
    }
    
    func move(to_x: CGFloat, frame_range_x: ClosedRange<CGFloat>) {
        self.shape?.position.x = GameUtils.keepCircleCenterInRange(center: to_x, range: frame_range_x, radius: self.radius!)
    }
    
}
