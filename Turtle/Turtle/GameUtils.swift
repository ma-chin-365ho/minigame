//
//  GameUtils.swift
//  Turtle
//
//  Created by 佐藤優成 on R 6/02/18.
//

import Foundation

class GameUtils {
    
    /*
     度数からラジアンに変換するメソッド
     */
    static func degreeToRadian(degree : Double!)-> CGFloat{
        return CGFloat(degree) / CGFloat(180.0 * M_1_PI)
    }
}
