//
//  SKLife.swift
//  LifeGame
//
//  Created by 佐藤優成 on R 6/02/05.
//

import Foundation
import SpriteKit

let CELL_WIDTH : CGFloat = 10.0
let CELL_HEIGHT : CGFloat = 10.0

class SKLife : Life {
    
    var cellNodes : [[SKShapeNode?]]?
    var originPos : CGPoint?

    init(frameX: CGFloat, frameY: CGFloat) {
        super.init()
        
        self.cellNodes = Array(repeating: Array(repeating: nil, count: CELLS_X_SIZE), count: CELLS_Y_SIZE)
        
        self.originPos = getOriginPos(frameX: frameX, frameY: frameY)
        
        for x in 0..<CELLS_X_SIZE {
            for y in 0..<CELLS_Y_SIZE {
                self.cellNodes?[y][x] = SKShapeNode(rectOf: CGSize(width: CELL_WIDTH, height:CELL_HEIGHT))
                self.cellNodes?[y][x]?.strokeColor = .blue
                self.cellNodes?[y][x]?.fillColor = self.getCellColor(cell: DEATH)
                self.cellNodes?[y][x]?.position = self.getCellPos(x: x, y: y)
            }
        }
    }
    
    override func next() {
        super.next()
        self.draw()
    }
    
    func draw() {
        for x in 0..<CELLS_X_SIZE {
            for y in 0..<CELLS_Y_SIZE {
                self.cellNodes?[y][x]?.fillColor = self.getCellColor(cell: self.cells[y][x])
            }
        }
    }
    
    func toggle(pos : CGPoint) {
        let xy = getCellXY(pos: pos)
        if xy != nil {
            super.toggle(x: xy!.x, y: xy!.y)
        }
    }
    
    func toLife(pos : CGPoint) {
        let xy = getCellXY(pos: pos)
        if xy != nil {
            super.toLife(x: xy!.x, y: xy!.y)
        }
    }

    func toDeath(pos : CGPoint) {
        let xy = getCellXY(pos: pos)
        if xy != nil {
            super.toDeath(x: xy!.x, y: xy!.y)
        }
    }
    
    func setPattern(pos: CGPoint, cellsPattern: [[Cell]]) {
        let xy = getCellXY(pos: pos)
        if xy != nil {
            super.setPattern(x: xy!.x, y: xy!.y, cellsPattern: cellsPattern)
        }
    }
    
    func getOriginPos(frameX: CGFloat, frameY: CGFloat) -> CGPoint {
        return CGPoint(
            x: frameX - (CELL_WIDTH * CGFloat(CELLS_X_SIZE / 2)),
            y: frameY - (CELL_HEIGHT * CGFloat(CELLS_Y_SIZE / 2))
        )
    }
    
    func getCellPos(x : Int, y: Int) -> CGPoint {
        let posX :CGFloat = self.originPos!.x + (CGFloat(x) * CELL_WIDTH)
        let posY :CGFloat = self.originPos!.y + ((CELL_HEIGHT * CGFloat(CELLS_Y_SIZE - 1)) - (CELL_HEIGHT * CGFloat(y)))

        return CGPoint(x: posX, y: posY)
    }
    
    func getCellXY(pos : CGPoint) -> (x: Int, y: Int)? {
        var xy : (x: Int, y: Int)? = nil
        
        for x in 0..<CELLS_X_SIZE {
            for y in 0..<CELLS_Y_SIZE {
                let nowCellPos = self.getCellPos(x: x, y: y)
                
                if (
                    ((nowCellPos.x - (CELL_WIDTH / 2)) <= pos.x) &&
                    (pos.x <= (nowCellPos.x + (CELL_WIDTH / 2))) &&
                    ((nowCellPos.y - (CELL_HEIGHT / 2)) <= pos.y) &&
                    (pos.y <= (nowCellPos.y + (CELL_HEIGHT / 2)))
                )
                {
                    xy = (x: x, y: y)
                    break
                }
            }
            if xy != nil { break }
        }
        return xy
    }
                                             
    func getCellColor(cell : Cell) -> NSColor {
        if cell == LIFE {
            return .yellow
        } else {
            return .black
        }
    }
}
