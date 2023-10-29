//
//  GameUtil.swift
//  Tetris
//
//  Created by 佐藤優成 on R 5/10/29.
//

import Foundation

class GameUtils {
    
    /*
     度数からラジアンに変換するメソッド
    */
    static func degreeToRadian(degree : Double!)-> CGFloat{
        return CGFloat(degree) / CGFloat(180.0 * M_1_PI)
    }
    
    /*
     ある座標を中心として円周上を指定された角度分移動
     */
    static func moveByAngle(trgPoint:CGPoint, centerPoint: CGPoint, degree : Double!)-> CGPoint{
        // centerPointが原点に来るように移動
        let trgPointOrg = CGPoint(
            x: trgPoint.x - centerPoint.x,
            y: trgPoint.y - centerPoint.y
        )
        
        // 回転行列で原点を中心に回転
        /*
             cos -sin
             sin cos
         */
        let radian = self.degreeToRadian(degree: degree)
        let trgPointRotated = CGPoint(
            x: (trgPointOrg.x * cos(radian)) - (trgPointOrg.y * sin(radian)),
            y: (trgPointOrg.x * sin(radian)) + (trgPointOrg.y * cos(radian))
        )
        
        // 原点をcenterPointに戻す。
        return CGPoint(
            x: round(trgPointRotated.x + centerPoint.x),
            y: round(trgPointRotated.y + centerPoint.y)
        )
    }
}
