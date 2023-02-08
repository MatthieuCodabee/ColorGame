//
//  Floor.swift
//  ColorGame
//
//  Created by matthieu passerel on 08/02/2023.
//

import SpriteKit

class Floor: SKNode {
    
    func setup(scene: SKScene) {
        position = CGPoint(x: 0, y: -scene.size.height / 2)
        let body = SKPhysicsBody(rectangleOf: CGSize(width: scene.size.width, height: 1))
        body.affectedByGravity = false
        body.isDynamic = false
        body.categoryBitMask = MASK_FLOOR
        physicsBody = body
    }
}
