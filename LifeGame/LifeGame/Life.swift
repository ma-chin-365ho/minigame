//
//  Life.swift
//  LifeGame
//
//  Created by 佐藤優成 on R 6/02/05.
//

import Foundation

let CELLS_X_SIZE : Int = 30 * 2
let CELLS_Y_SIZE : Int = 30 * 2

typealias Cell = Int
let LIFE : Cell = 1
let DEATH : Cell = 0

class Life {
    var cells: [[Cell]]
 
    init() {
        self.cells = Array(repeating: Array(repeating: DEATH, count: CELLS_X_SIZE), count: CELLS_Y_SIZE)
    }
    
    func next() {
        let cells_ago: [[Cell]] = self.cells
        
        for y in 0..<CELLS_Y_SIZE {
            for x in 0..<CELLS_X_SIZE {
                let cc:Cell = cells_ago[y][x]
                let ul:Cell = (y-1>=0 && x-1>=0) ? cells_ago[y-1][x-1] : DEATH
                let uc:Cell = (y-1>=0) ? cells_ago[y-1][x] : DEATH
                let ur:Cell = (y-1>=0 && x+1<CELLS_X_SIZE) ? cells_ago[y-1][x+1] : DEATH
                let cr:Cell = (x+1<CELLS_X_SIZE) ? cells_ago[y][x+1] : DEATH
                let lr:Cell = (y+1<CELLS_Y_SIZE && x+1<CELLS_X_SIZE) ? cells_ago[y+1][x+1] : DEATH
                let lc:Cell = (y+1<CELLS_Y_SIZE) ? cells_ago[y+1][x] : DEATH
                let ll:Cell = (y+1<CELLS_Y_SIZE && x-1>=0) ? cells_ago[y+1][x-1] : DEATH
                let cl:Cell = (x-1>=0) ? cells_ago[y][x-1] : DEATH
                
                self.cells[y][x] = self.decideLifeOrDeath(cc:cc, ul:ul, uc:uc, ur:ur, cr:cr, lr:lr, lc:lc, ll:ll, cl:cl)
            }
        }
    }
    
    func decideLifeOrDeath (cc: Cell, ul : Cell, uc: Cell, ur: Cell, cr: Cell, lr: Cell, lc: Cell, ll: Cell, cl: Cell) -> Cell {
        let cells : [Cell] = [ul, uc, ur, cr, lr, lc, ll, cl]
        let count = cells.filter { $0 == LIFE }.count
        
        
        if (cc == LIFE) {
            if (count == 2) || (count == 3) {
                return LIFE
            } else {
                return DEATH
            }
        } else {
            if (count == 3) {
                return LIFE
            } else {
                return DEATH
            }
        }
    }
    
    func toggle(x: Int, y: Int) {
        if self.cells[y][x] == LIFE {
            self.cells[y][x] = DEATH
        } else {
            self.cells[y][x] = LIFE
        }
    }
    
    func toLife(x: Int, y: Int) {
        self.cells[y][x] = LIFE
    }
    
    func toDeath(x: Int, y: Int) {
        self.cells[y][x] = DEATH
    }
    
    func setPattern(x: Int, y: Int, cellsPattern: [[Cell]]) {
        let lenCellsPatternY = cellsPattern.count
        
        for cpY in 0..<lenCellsPatternY {
            let lenCellsPatternX = cellsPattern[cpY].count
            for cpX in 0..<lenCellsPatternX {
                let cX = x + (cpX - Int(lenCellsPatternX / 2)) + (1 - (lenCellsPatternX % 2))
                let cY = y + (cpY - Int(lenCellsPatternY / 2)) + (1 - (lenCellsPatternY % 2))
                
                if (
                    (cX >= 0) &&
                    (cX < CELLS_X_SIZE) &&
                    (cY >= 0) &&
                    (cY < CELLS_Y_SIZE)
                ) {
                    self.cells[cY][cX] = cellsPattern[cpY][cpX]
                }
            }
        }
    }
}

