//
//  TurtleController.swift
//  Turtle
//
//  Created by 佐藤優成 on R 6/02/18.
//

import Foundation

enum Ope: Character {
    case forward = "F"
    case forwardA = "A"
    case forwardB = "B"
    case goto = "G"
    case doNothingL = "L"
    case doNothingM = "M"
    case doNothingN = "N"
    case doNothingR = "R"
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
                case Ope.forwardA.rawValue:
                    self.opes.append(.forwardA)
                case Ope.forwardB.rawValue:
                    self.opes.append(.forwardB)
                case Ope.goto.rawValue:
                    self.opes.append(.goto)
                case Ope.doNothingL.rawValue:
                    self.opes.append(.doNothingL)
                case Ope.doNothingR.rawValue:
                    self.opes.append(.doNothingR)
                case Ope.doNothingM.rawValue:
                    self.opes.append(.doNothingM)
                case Ope.doNothingN.rawValue:
                    self.opes.append(.doNothingN)
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
        if self.opes.count > 0 {
            self.operate(ope: self.opes[0])
            self.opes.removeFirst()
            return true
        } else {
            return false
        }
    }
    
    private func operate(ope : Ope) {
        switch ope {
            case .forward:
                self.turtle?.forward(distance : self.forwardDistance, isUpdateTrack: true)
            case .forwardA:
                self.turtle?.forward(distance : self.forwardDistance, isUpdateTrack: true)
            case .forwardB:
                self.turtle?.forward(distance : self.forwardDistance, isUpdateTrack: true)
            case .goto:
                self.turtle?.forward(distance : self.forwardDistance, isUpdateTrack: false)
            case .doNothingL:
                break // Do Nothing
            case .doNothingR:
                break // Do Nothing
            case .doNothingM:
                break // Do Nothing
            case .doNothingN:
                break // Do Nothing
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
