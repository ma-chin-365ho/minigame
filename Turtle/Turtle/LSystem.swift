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

// レヴィC曲線
let LEVY_C_CURVE = LSystem(
    startX: -250.0,
    startY: -250.0,
    startAngleDeg : 0.0,
    forwardDistance: 20.0,
    trackLineWidth : 5.0,
    rotationDeg: 45.0,
    startCmd: "F",
    rewirteRule: ["F": "+F--F+"]
)

// ピアノ曲線
let PEANO_CURVE = LSystem(
    startX: -250.0,
    startY: 0.0,
    startAngleDeg : 0.0,
    forwardDistance: 20.0,
    trackLineWidth : 5.0,
    rotationDeg: 90.0,
    startCmd: "F",
    rewirteRule: ["F": "F+F-F-F-F+F+F+F-F"]
)

// ピアノ-ゴスペル曲線
let PEANO_GOSPER_CURVE = LSystem(
    startX: -250.0,
    startY: 0.0,
    startAngleDeg : 0.0,
    forwardDistance: 20.0,
    trackLineWidth : 5.0,
    rotationDeg: 60.0,
    startCmd: "L",
    rewirteRule: ["L": "L+RF++RF-FL--FLFL-RF+", "R": "-FL+RFRF++RF+FL--FL-R"]
)


// カントール集合
let CANTOR_SET = LSystem(
    startX: -400.0,
    startY: 0.0,
    startAngleDeg : 0.0,
    forwardDistance: 20.0,
    trackLineWidth : 100.0,
    rotationDeg: 0.0,
    startCmd: "F",
    rewirteRule: ["F": "FGF", "G": "GGG"]
)

// Pentigree
let PENTIGREE = LSystem(
    startX: -350.0,
    startY: -250.0,
    startAngleDeg : 0.0,
    forwardDistance: 20.0,
    trackLineWidth : 3.0,
    rotationDeg: 36.0,
    startCmd: "F",
    rewirteRule: ["F": "+F++F----F--F++F++F-"]
)

// ペンローズタイル
let PENROSE_TILES = LSystem(
    startX: 0.0,
    startY: 0.0,
    startAngleDeg : 0.0,
    forwardDistance: 20.0,
    trackLineWidth : 3.0,
    rotationDeg: 36.0,
    startCmd: "[L]++[L]++[L]++[L]++[L]",
    rewirteRule: [
        "L": "+NF--RF[---MF--LF]+",
        "M": "NF++RF----LF[-NF----MF]++",
        "N": "-MF++LF[+++NF++RF]-",
        "R": "--NF++++MF[+RF++++LF]--LF",
        "F": ""
    ]
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

// fractal plant
let TREE_03 = LSystem(
    startX: 0.0,
    startY: -300.0,
    startAngleDeg : 90.0,
    forwardDistance: 3.0,
    trackLineWidth : 0.5,
    rotationDeg: 25.0,
    startCmd: "L",
    rewirteRule: ["L": "F+[[L]-L]-F[-FL]+L", "F": "FF"]
)

// fractal (binary) tree
let TREE_04 = LSystem(
    startX: 0.0,
    startY: -300.0,
    startAngleDeg : 90.0,
    forwardDistance: 20.0,
    trackLineWidth : 10,
    rotationDeg: 45.0,
    startCmd: "A",
    rewirteRule: ["A": "B[+A]-A", "B": "BB", ]
)

