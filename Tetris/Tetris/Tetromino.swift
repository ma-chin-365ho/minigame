//
//  Tetromino.swift
//  Tetris
//
//  Created by 佐藤優成 on R 5/10/28.
//

import Foundation
import SpriteKit

let cellSize: CGFloat = 30 // 偶数にする。
let xCellCount :CGFloat = (8 * 2) + 1 // 奇数にする。
let yCellCount :CGFloat = (12 * 2) // 偶数にする・

class Tetromino {
    
    var minos :[SKShapeNode] = []
    // var angle : Int = 0 // 角度。0: 基準の向き、 90、180、270 の4種類。左回転。
    var minoCenter :SKShapeNode?
    
    func rotate(direction : String, centerPos: CGPoint, stackMinos: [SKShapeNode]) {
        
        var degree = 0.0
        var toPos : CGPoint
        var isAbleRotate: Bool = true

        if (direction == "l") {
            degree = 90.0
        } else if (direction == "r") {
            degree = 270.0
        }

        // 壁のX座標取得
        let xFrameL = self.getFrameBoderXL(centerPos: centerPos)
        let xFrameR = self.getFrameBoderXR(centerPos: centerPos)
        let yFrameU = self.getFrameBoderYU(centerPos: centerPos)

        for mino in self.minos {
            toPos = GameUtils.moveByAngle(trgPoint: mino.position, centerPoint: self.minoCenter!.position, degree: degree)
            
            // 壁から外に出てないかどうか
            if (toPos.x < xFrameL) {
                isAbleRotate = false
                break
            }
            
            if (toPos.x > xFrameR) {
                isAbleRotate = false
                break
            }

            if (toPos.y <= yFrameU) {
                isAbleRotate = false
                break
            }
            
            // 積まれているminoに触れてないかどうか
            for stackMino in stackMinos {
                // 同じx座標にある。
                if round(toPos.x) == round(stackMino.position.x) {
                    
                    if (round(toPos.y) == round(stackMino.position.y)) {
                        isAbleRotate = false
                        break
                    }
                }
                // 同じy座標にある。
                if round(toPos.y) == round(stackMino.position.y) {
                    
                    if (round(toPos.x) == round(stackMino.position.x)) {
                        isAbleRotate = false
                        break
                    }
                }
            }
        }

        if (isAbleRotate == true) {
            for mino in self.minos {
                toPos = GameUtils.moveByAngle(trgPoint: mino.position, centerPoint: self.minoCenter!.position, degree: degree)
                mino.run(SKAction.move(to: toPos, duration: 0.0))
            }
        }
    }
    
    func move(direction : String, centerPos: CGPoint, stackMinos: [SKShapeNode]) {
        var nextPos : CGPoint?
        var moveBy : CGPoint?
        var isAbleMove: Bool = true
        
        if direction == "u" {
            moveBy = CGPoint(
                x: 0,
                y: cellSize * (-1)
            )
        } else if direction == "l" {
            moveBy = CGPoint(
                x: cellSize * (-1),
                y: 0
            )
        } else if direction == "r" {
            moveBy = CGPoint(
                x: cellSize,
                y: 0
            )
        }
        
        // 壁のX,Y座標取得
        let xFrameL = self.getFrameBoderXL(centerPos: centerPos)
        let xFrameR = self.getFrameBoderXR(centerPos: centerPos)
        let yFrameU = self.getFrameBoderYU(centerPos: centerPos)

        // 移動可能かチェック
        for mino in self.minos {
            nextPos = CGPoint(
                x: round(mino.position.x + moveBy!.x),
                y: round(mino.position.y + moveBy!.y)
            )
            
            // 壁から外に出てないかどうか
            if (nextPos!.x < xFrameL) {
                isAbleMove = false
                break
            }
            
            if (nextPos!.x > xFrameR) {
                isAbleMove = false
                break
            }
            
            if (nextPos!.y <= yFrameU) {
                isAbleMove = false
                break
            }
            
            // 積まれているminoに触れてないかどうか
            for stackMino in stackMinos {
                // 同じx座標にある。
                if round(nextPos!.x) == round(stackMino.position.x) {
                    
                    if (round(nextPos!.y) == round(stackMino.position.y)) {
                        isAbleMove = false
                        break
                    }
                }
                // 同じy座標にある。
                if round(nextPos!.y) == round(stackMino.position.y) {
                    
                    if (round(nextPos!.x) == round(stackMino.position.x)) {
                        isAbleMove = false
                        break
                    }
                }
            }
        }
        
        // 移動
        if (isAbleMove == true) {
            for mino in self.minos {
                // WARNING: 落下動作中に回転しようとすると、y座標軸の分解能とズレてしまうので、一旦落下動作は0秒にしている。
                mino.run(SKAction.moveBy(x: moveBy!.x, y: moveBy!.y, duration: 0))
            }
        }
    }
    
    // テトリミノが固まるかどうか
    func isHarden(centerPos: CGPoint, stackMinos: [SKShapeNode]) -> Bool {
        var isOK: Bool = false
        
        // 壁の下のY座標取得
        let yFrameU = self.getFrameBoderYU(centerPos: centerPos)

        // 固まるかチェック
        for mino in self.minos {
            // ブロックが壁に触れてるかどうか？
            // NOTE: minoの中心とminoの下境界線の距離がcellSize / 2
            if (round(mino.position.y - (cellSize / 2)) <= yFrameU) {
                isOK = true
                break
            }
            
            // ブロックが積まれてるテトリミノの上側に触れているかどうか
            for stackMino in stackMinos {
                // 同じx座標にある。
                if round(mino.position.x) == round(stackMino.position.x) {
                    
                    if (round(mino.position.y - cellSize) == round(stackMino.position.y)) {
                        isOK = true
                        break
                    }
                }
            }
        }
        
        return isOK
    }
    
    // 左の壁のX座標
    func getFrameBoderXL(centerPos: CGPoint) -> CGFloat{
        
        return round(centerPos.x - (cellSize * (xCellCount - 1) / 2))
    }
    
    // 左の壁のX座標
    func getFrameBoderXR(centerPos: CGPoint) -> CGFloat {

        return round(centerPos.x + (cellSize * (xCellCount - 1) / 2))
    }
    
    // 下の壁のY座標
    func getFrameBoderYU(centerPos: CGPoint) -> CGFloat {

        return round(centerPos.y - (cellSize * yCellCount / 2))
    }

}

class BlockT : Tetromino {
    private var minoL : SKShapeNode
    private var minoC : SKShapeNode
    private var minoR : SKShapeNode
    private var minoU : SKShapeNode
    
    init(pos: CGPoint) {
        self.minoL = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoL.position = CGPoint(x:pos.x - cellSize, y:pos.y)
        self.minoL.fillColor = .magenta
        self.minoC = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoC.position = CGPoint(x:pos.x, y:pos.y)
        self.minoC.fillColor = .magenta
        self.minoR = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoR.position = CGPoint(x:pos.x + cellSize, y:pos.y)
        self.minoR.fillColor = .magenta
        self.minoU = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoU.position = CGPoint(x:pos.x, y:pos.y - cellSize)
        self.minoU.fillColor = .magenta
        
        super.init()
        super.minos.append(contentsOf: [
            self.minoL, self.minoC, self.minoR, self.minoU])
        super.minoCenter = self.minoC
    }    
}


class BlockI : Tetromino {
    private var minoL : SKShapeNode
    private var minoC : SKShapeNode
    private var minoR : SKShapeNode
    private var minoU : SKShapeNode
    
    init(pos: CGPoint) {
        self.minoL = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoL.position = CGPoint(x:pos.x - cellSize, y:pos.y)
        self.minoL.fillColor = .cyan
        self.minoC = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoC.position = CGPoint(x:pos.x, y:pos.y)
        self.minoC.fillColor = .cyan
        self.minoR = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoR.position = CGPoint(x:pos.x + cellSize, y:pos.y)
        self.minoR.fillColor = .cyan
        self.minoU = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoU.position = CGPoint(x:pos.x + cellSize + cellSize, y:pos.y )
        self.minoU.fillColor = .cyan
        
        super.init()
        super.minos.append(contentsOf: [
            self.minoL, self.minoC, self.minoR, self.minoU])
        super.minoCenter = self.minoC
    }
}

class BlockO : Tetromino {
    private var minoL : SKShapeNode
    private var minoC : SKShapeNode
    private var minoR : SKShapeNode
    private var minoU : SKShapeNode
    
    init(pos: CGPoint) {
        self.minoL = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoL.position = CGPoint(x:pos.x - cellSize, y:pos.y)
        self.minoL.fillColor = .yellow
        self.minoC = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoC.position = CGPoint(x:pos.x, y:pos.y)
        self.minoC.fillColor = .yellow
        self.minoR = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoR.position = CGPoint(x:pos.x, y:pos.y - cellSize)
        self.minoR.fillColor = .yellow
        self.minoU = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoU.position = CGPoint(x:pos.x - cellSize, y:pos.y - cellSize)
        self.minoU.fillColor = .yellow
        
        super.init()
        super.minos.append(contentsOf: [
            self.minoL, self.minoC, self.minoR, self.minoU])
        super.minoCenter = self.minoC
    }
}


class BlockL : Tetromino {
    private var minoL : SKShapeNode
    private var minoC : SKShapeNode
    private var minoR : SKShapeNode
    private var minoU : SKShapeNode
    
    init(pos: CGPoint) {
        self.minoL = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoL.position = CGPoint(x:pos.x, y:pos.y + cellSize)
        self.minoL.fillColor = .orange
        self.minoC = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoC.position = CGPoint(x:pos.x, y:pos.y)
        self.minoC.fillColor = .orange
        self.minoR = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoR.position = CGPoint(x:pos.x, y:pos.y - cellSize)
        self.minoR.fillColor = .orange
        self.minoU = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoU.position = CGPoint(x:pos.x + cellSize, y:pos.y - cellSize)
        self.minoU.fillColor = .orange
        
        super.init()
        super.minos.append(contentsOf: [
            self.minoL, self.minoC, self.minoR, self.minoU])
        super.minoCenter = self.minoC
    }
}


class BlockS : Tetromino {
    private var minoL : SKShapeNode
    private var minoC : SKShapeNode
    private var minoR : SKShapeNode
    private var minoU : SKShapeNode
    
    init(pos: CGPoint) {
        self.minoL = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoL.position = CGPoint(x:pos.x, y:pos.y + cellSize)
        self.minoL.fillColor = .green
        self.minoC = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoC.position = CGPoint(x:pos.x, y:pos.y)
        self.minoC.fillColor = .green
        self.minoR = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoR.position = CGPoint(x:pos.x + cellSize, y:pos.y)
        self.minoR.fillColor = .green
        self.minoU = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoU.position = CGPoint(x:pos.x + cellSize, y:pos.y - cellSize)
        self.minoU.fillColor = .green
        
        super.init()
        super.minos.append(contentsOf: [
            self.minoL, self.minoC, self.minoR, self.minoU])
        super.minoCenter = self.minoC
    }
}

class BlockJ : Tetromino {
    private var minoL : SKShapeNode
    private var minoC : SKShapeNode
    private var minoR : SKShapeNode
    private var minoU : SKShapeNode
    
    init(pos: CGPoint) {
        self.minoL = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoL.position = CGPoint(x:pos.x, y:pos.y + cellSize)
        self.minoL.fillColor = .blue
        self.minoC = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoC.position = CGPoint(x:pos.x, y:pos.y)
        self.minoC.fillColor = .blue
        self.minoR = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoR.position = CGPoint(x:pos.x, y:pos.y - cellSize)
        self.minoR.fillColor = .blue
        self.minoU = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoU.position = CGPoint(x:pos.x - cellSize, y:pos.y - cellSize)
        self.minoU.fillColor = .blue
        
        super.init()
        super.minos.append(contentsOf: [
            self.minoL, self.minoC, self.minoR, self.minoU])
        super.minoCenter = self.minoC
    }
}


class BlockZ : Tetromino {
    private var minoL : SKShapeNode
    private var minoC : SKShapeNode
    private var minoR : SKShapeNode
    private var minoU : SKShapeNode
    
    init(pos: CGPoint) {
        self.minoL = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoL.position = CGPoint(x:pos.x, y:pos.y + cellSize)
        self.minoL.fillColor = .white
        self.minoC = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoC.position = CGPoint(x:pos.x, y:pos.y)
        self.minoC.fillColor = .white
        self.minoR = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoR.position = CGPoint(x:pos.x - cellSize, y:pos.y)
        self.minoR.fillColor = .white
        self.minoU = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.minoU.position = CGPoint(x:pos.x - cellSize, y:pos.y - cellSize)
        self.minoU.fillColor = .white
        
        super.init()
        super.minos.append(contentsOf: [
            self.minoL, self.minoC, self.minoR, self.minoU])
        super.minoCenter = self.minoC
    }
}
