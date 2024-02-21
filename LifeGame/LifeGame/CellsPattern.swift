//
//  CellPatterns.swift
//  LifeGame
//
//  Created by 佐藤優成 on R 6/02/21.
//

import Foundation

class CellsPattern {
    
    static let Block : [[Cell]] = [
        [DEATH, DEATH, DEATH, DEATH,],
        [DEATH, LIFE,  LIFE,  DEATH,],
        [DEATH, LIFE,  LIFE,  DEATH,],
        [DEATH, DEATH, DEATH, DEATH,],
    ]
    
    static let Blinker : [[Cell]] = [
        [DEATH, DEATH, DEATH, DEATH, DEATH,],
        [DEATH, DEATH, LIFE,  DEATH, DEATH,],
        [DEATH, DEATH, LIFE,  DEATH, DEATH,],
        [DEATH, DEATH, LIFE,  DEATH, DEATH,],
        [DEATH, DEATH, DEATH, DEATH, DEATH,],
    ]
    
    static let Glider : [[Cell]] = [
        [DEATH, DEATH, DEATH, DEATH, DEATH,],
        [DEATH, LIFE,  LIFE,  LIFE,  DEATH,],
        [DEATH, LIFE,  DEATH, DEATH, DEATH,],
        [DEATH, DEATH, LIFE,  DEATH, DEATH,],
        [DEATH, DEATH, DEATH, DEATH, DEATH,],
    ]
}
