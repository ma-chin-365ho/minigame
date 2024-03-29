//
//  Turtle.swift
//  Turtle
//
//  Created by 佐藤優成 on R 6/02/18.
//

import Foundation

enum Direction {
    case right
    case left
}

struct Vec {
    var x: Double
    var y: Double
    var angleDeg: Double
}

protocol Turtle {
    func forward(distance : Double, isUpdateTrack: Bool)
    func warp(vec: Vec)
    func rotate(direction : Direction, degree : Double)
    func getVec() -> Vec
}


