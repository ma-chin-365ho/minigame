//
//  LSystem.swift
//  Turtle
//
//  Created by 佐藤優成 on R 6/02/18.
//

import Foundation

struct LSystem {
    var startX : Double
    var startY : Double
    var startAngleDeg : Double
    var forwardDistance : Double
    var trackLineWidth : Double
    var rotationDeg : Double
    var startCmd : String
    var rewirteRule : Dictionary<String, String>
}

class LSystemUtil {
    static func rewrite(startCmd: String, rewirteRule : Dictionary<String, String>, count : Int) -> String {
        var cmd : String = startCmd
        
        if (count > 0) {
            for _ in 1...count {
                let opes = Array(cmd)
                cmd = ""
                for ope in opes {
                    if (rewirteRule.keys.contains(String(ope))) {
                        cmd += rewirteRule[String(ope)]!
                    } else {
                        cmd += String(ope)
                    }
                }
            }
        }
        return cmd
    }
}

// コッホ曲線
let KOCH_CURVE = LSystem(
    startX: -350.0,
    startY: -250.0,
    startAngleDeg : 0.0,
    forwardDistance: 30.0,
    trackLineWidth : 6.0,
    rotationDeg: 60.0,
    startCmd: "F",
    rewirteRule: ["F": "F+F--F+F"]
)

// ドラゴン曲線
let DRAGON_CURVE = LSystem(
    startX: 0.0,
    startY: -200.0,
    startAngleDeg : 90.0,
    forwardDistance: 30.0,
    trackLineWidth : 6.0,
    rotationDeg: 90.0,
    startCmd: "A",
    rewirteRule: ["A": "A+B+", "B": "-A-B"]
)

// シェルピンスキーのギャスケット オメガ形
let SIERPINSKI_GASKET_01 = LSystem(
    startX: 0.0,
    startY: 0.0,
    startAngleDeg : 0.0,
    forwardDistance: 30.0,
    trackLineWidth : 6.0,
    rotationDeg: 60,
    startCmd: "B",
    rewirteRule: ["A": "B+A+B", "B": "A-B-A"]
)

// シェルピンスキーのギャスケット 三角形
let SIERPINSKI_GASKET_02 = LSystem(
    startX: 300.0,
    startY: -300.0,
    startAngleDeg : 180.0,
    forwardDistance: 30.0,
    trackLineWidth : 6.0,
    rotationDeg: 120.0,
    startCmd: "R-F-F",
    rewirteRule: ["F": "FF", "R": "F-R+R+R-F"]
)

// ヒルベルト曲線
let HILBERT_CURVE = LSystem(
    startX: -350.0,
    startY: -250.0,
    startAngleDeg : 0.0,
    forwardDistance: 30.0,
    trackLineWidth : 6.0,
    rotationDeg: 90.0,
    startCmd: "L",
    rewirteRule: ["L": "+RF-LFL-FR+", "R": "-LF+RFR+FL-"]
)

// 木
let TREE_01 = LSystem(
    startX: 0.0,
    startY: -300.0,
    startAngleDeg : 90.0,
    forwardDistance: 30.0,
    trackLineWidth : 6.0,
    rotationDeg: 60.0,
    startCmd: "F",
    rewirteRule: ["F": "F[+FF]F[-F]F"]
)

let TREE_02 = LSystem(
    startX: 0.0,
    startY: -300.0,
    startAngleDeg : 90.0,
    forwardDistance: 3.0,
    trackLineWidth : 0.5,
    rotationDeg: 30.0,
    startCmd: "F",
    rewirteRule: ["F": "FF-[-F+F]+[+F-F]"]
)


