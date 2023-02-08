//
//  Obstacle.swift
//  ColorGame
//
//  Created by matthieu passerel on 08/02/2023.
//

import SpriteKit

class Obstacle: SKNode {
    
    func setup() {
        guard let path = createShape() else { return }
        zPosition = 0
        for x in (0..<4) {
            let quarter = SKShapeNode(path: path.cgPath)
            quarter.fillColor = colors[x]
            quarter.strokeColor = colors[x]
            quarter.zRotation = CGFloat(Double.pi / 2) * CGFloat(x)
            let body = SKPhysicsBody(polygonFrom: path.cgPath)
            body.categoryBitMask = MASK_OBSTACLE
            body.collisionBitMask = MASK_COLLISION_PLAYER
            body.contactTestBitMask = MASK_PLAYER
            body.affectedByGravity = false
            quarter.physicsBody = body
            addChild(quarter)
        }
        let angle = (arc4random_uniform(2) == 0) ? CGFloat(Double.pi) : CGFloat(-Double.pi)
        let duration = TimeInterval(Int.random(in: 2..<7))
        let action = SKAction.rotate(byAngle: angle, duration: duration)
        let repeatForever = SKAction.repeatForever(action)
        run(repeatForever)
        
    }
    
    func createShape() -> UIBezierPath? {
        return nil
    }
}

class Rectangle: Obstacle {
    
    override func setup() {
        super.setup()
    }
    
    override func createShape() -> UIBezierPath? {
        return UIBezierPath(
            roundedRect: CGRect(
                x: -100,
                y: -100,
                width: 200,
                height: 20
            ),
            cornerRadius: 10
        )
    }
    
}

class Circle: Obstacle {
    override func setup() {
        super.setup()
    }
    
    override func createShape() -> UIBezierPath? {
        let path = UIBezierPath()
        let startAngle = CGFloat(Double.pi / 2) * 3
        path.move(to: CGPoint(x: 0, y: -100))
        path.addLine(to: CGPoint(x: 0, y: -80))
        path.addArc(withCenter: CGPoint.zero, radius: 80, startAngle: startAngle, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: 100, y: 0))
        path.addArc(withCenter: CGPoint.zero, radius: 100, startAngle: 0, endAngle: startAngle, clockwise: false)
        return path
    }
}
