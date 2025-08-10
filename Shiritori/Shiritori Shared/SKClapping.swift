//
//  SKClapping.swift
//  Shiritori
//
//  Created by 佐藤優成 on R 6/04/07.
//

import Foundation
import SpriteKit

class SKClapping {

    fileprivate var clickAudioNode : SKAudioNode = SKAudioNode(
        fileNamed: "Press_the_OK_button34.mp3"
    )
    
    init(scene : SKScene) {
        self.clickAudioNode.autoplayLooped = false
        scene.addChild(self.clickAudioNode)
    }
    
    func clap() {
        let stopAction = SKAction.stop()
        self.clickAudioNode.run(stopAction)
        let playAction = SKAction.play()
        self.clickAudioNode.run(playAction)
    }
    
    
    
}
