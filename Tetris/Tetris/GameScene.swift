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
        var block : Tetromino?
        switch Int.random(in: 1..<8) {
        case 1:
            block = BlockT(pos : CGPoint(x:self.frame.midX, y:self.frame.midY + (((cellSize * yCellCount) / 2) + cellSize / 2)))
        case 2:
            block = BlockI(pos : CGPoint(x:self.frame.midX, y:self.frame.midY + (((cellSize * yCellCount) / 2) + cellSize / 2)))
        case 3:
            block = BlockO(pos : CGPoint(x:self.frame.midX, y:self.frame.midY + (((cellSize * yCellCount) / 2) + cellSize / 2)))
        case 4:
            block = BlockL(pos : CGPoint(x:self.frame.midX, y:self.frame.midY + (((cellSize * yCellCount) / 2) + cellSize / 2)))
        case 5:
            block = BlockS(pos : CGPoint(x:self.frame.midX, y:self.frame.midY + (((cellSize * yCellCount) / 2) + cellSize / 2)))
        case 6:
            block = BlockJ(pos : CGPoint(x:self.frame.midX, y:self.frame.midY + (((cellSize * yCellCount) / 2) + cellSize / 2)))
        case 7:
            block = BlockZ(pos : CGPoint(x:self.frame.midX, y:self.frame.midY + (((cellSize * yCellCount) / 2) + cellSize / 2)))
        default:
            print("")
        }

        for mino in block!.minos {
            self.addChild(mino)
        }
        self.nowBlock = block
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
    
    func delRows() {
        
        var minosPerRow: Dictionary<CGFloat, [SKShapeNode]> = [:]
        var rowNo : CGFloat = 0
        var delLineCnt : Int = 0
        for mino in self.stackMinos {
            rowNo = round(mino.position.y)
            if (minosPerRow.keys.contains(rowNo)) {
                minosPerRow[rowNo]!.append(mino)
            } else {
                minosPerRow[rowNo] = [mino]
            }
        }
        
        for row in minosPerRow.sorted(by: { $0.key < $1.key }) {
            if (row.value.count == Int(xCellCount)) {
                self.stackMinos.removeAll(where: { round($0.position.y) == row.key })
                self.removeChildren(in: row.value)
                delLineCnt += 1
            }
            if (delLineCnt > 0) {
                for mino in row.value {
                    mino.run(SKAction.moveBy(x: 0, y: CGFloat(Int(cellSize) * delLineCnt * (-1)), duration: 0))
                }
            }
        }
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
                self.delRows()
                self.genTetromino()
            } else {
                self.nowBlock?.move(direction : "u", centerPos: CGPoint(x: self.frame.midX, y: self.frame.midY), stackMinos: self.stackMinos)
            }
            self.lastRectTime = currentTime
        }

        self.lastUpdateTime = currentTime
    }
}
