//
//  Player.swift
//  ColorGame
//
//  Created by matthieu passerel on 08/02/2023.
//

import SpriteKit

class Player: SKShapeNode {
    
    func setup(scene: SKScene) {
        changeColor()
        position = CGPoint(x: 0, y: 0)
        let playerBody = SKPhysicsBody(circleOfRadius: 12)
        playerBody.affectedByGravity = true
        playerBody.mass = 1.5
        playerBody.categoryBitMask = MASK_PLAYER
        playerBody.collisionBitMask = MASK_FLOOR
        physicsBody = playerBody
        zPosition = 100
    }
    
    func jump() {
        physicsBody?.velocity.dy = 300
    }
    
    func changeColor() {
        let currentColor = fillColor
        let colorIndex = Int.random(in: 0..<colors.count)
        let color = colors[colorIndex]
        if currentColor == color {
            changeColor()
        } else {
            fillColor = color
            strokeColor = color
        }
        
    }
    
}
