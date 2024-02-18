//
//  TurtleController.swift
//  Turtle
//
//  Created by 佐藤優成 on R 6/02/18.
//

import Foundation

enum Ope: Character {
    case forward = "F"
    case rotateR = "-"
    case rotateL = "+"
    case push = "["
    case pop = "]"
}

class TurtleController {
    
    private var turtle : Turtle?
    private var stack : [Vec] = []
    private var opes : [Ope] = []
    private var forwardDistance: Double = 5.0
    private var rotationDeg: Double = 45.0
    
    init (turtle : Turtle) {
        self.turtle = turtle
    }
    
    func setConfig(forwardDistance: Double, rotationDeg: Double) {
        self.forwardDistance = forwardDistance
        self.rotationDeg = rotationDeg
    }
    
    func readCmd(cmd : String) throws {
        let opes = Array(cmd)
        for ope in opes {
            switch ope {
                case Ope.forward.rawValue:
                    self.opes.append(.forward)
                case Ope.rotateR.rawValue:
                    self.opes.append(.rotateR)
                case Ope.rotateL.rawValue:
                    self.opes.append(.rotateL)
                case Ope.push.rawValue:
                    self.opes.append(.push)
                case Ope.pop.rawValue:
                    self.opes.append(.pop)
                default:
                    throw NSError(domain: "error", code: -1, userInfo: nil)
            }
        }
    }
    
    func next() -> Bool {
        if let ope = self.opes.popLast() {
            self.operate(ope: ope)
            return true
        } else {
            return false
        }
    }
    
    private func operate(ope : Ope) {
        switch ope {
            case .forward:
                self.turtle?.forward(distance : self.forwardDistance)
            case .rotateR:
                self.turtle?.rotate(direction: Direction.right, degree: self.rotationDeg)
            case .rotateL:
                self.turtle?.rotate(direction: Direction.left, degree: self.rotationDeg)
            case .push:
                let vec = self.turtle!.getVec()
                self.stack.append(vec)
            case .pop:
                let vec : Vec? = self.stack.popLast()
                self.turtle?.warp(vec: vec!)
        }
    }
}
