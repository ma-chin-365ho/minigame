//
//  SKTrack.swift
//  Turtle
//
//  Created by 佐藤優成 on R 6/02/18.
//

import Foundation
import SpriteKit

class SKTrack : Track {
    
    var node : SKShapeNode?
    private var path : CGMutablePath?
    
    init(startPos: CGPoint, lineWidth : CGFloat) {
        self.node = SKShapeNode()
        self.node?.lineWidth = lineWidth
        self.node?.strokeColor = .brown
        // self.node?.fillColor = .brown
        self.path = CGMutablePath()
        self.path?.move(to: startPos)
        self.node?.path = self.path!
    }

    func update(x: Double, y: Double) {
        let toPoint = CGPoint(
            x: x,
            y: y
        )
        self.path?.addLine(to: toPoint)
        self.node?.path = self.path!
    }
}
