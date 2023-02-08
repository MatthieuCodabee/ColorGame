//
//  GameScene.swift
//  ColorGame
//
//  Created by matthieu passerel on 08/02/2023.
//

import SpriteKit

class GameScene: SKScene {
    var player: Player?
    var floor: Floor?
    var scoreText: Text?
    var gameOverText: Text?
    var cameraNode: SKCameraNode = SKCameraNode()
    var score = 0
    var obstacles: [Obstacle] = []
    
    
    func createAndAddPlayer() {
        player = Player(circleOfRadius: 12)
        player?.setup(scene: self)
        if player != nil {
            addChild(player!)
        }
    }
    
    func createAndAddFloor() {
        floor = Floor()
        floor?.setup(scene: self)
        if floor != nil {
            addChild(floor!)
        }
    }
    
    func createAndAddScore() {
        scoreText = Text()
        scoreText?.setup(
            position: CGPoint(x: -size.width / 2 + 50, y: -size.height / 2),
            size: 75
        )
        scoreText?.updateText(string: "\(score)")
        if scoreText != nil {
            cameraNode.addChild(scoreText!)
        }
     }
    
    func createAndAddObstacle() {
        let obstacle: Obstacle = (arc4random_uniform(2) == 0) ? Circle() : Rectangle()
        obstacle.setup()
        obstacles.append(obstacle)
        obstacle.position = CGPoint(
            x: cameraNode.frame.midX,
            y: CGFloat(obstacles.count) * 500
        )
        addChild(obstacle)
    }
    
    func createAndAddGameOverText() {
        gameOverText = Text()
        gameOverText?.setup(position: CGPoint.zero, size: 30)
        gameOverText?.updateText(string: "Game Over \n score: \(score)")
        if gameOverText != nil {
            cameraNode.addChild(gameOverText!)
        }
     }
    
    func gameOver() {
        if player != nil {
            player?.removeFromParent()
            player = nil
        }
        
        for obstacle in obstacles {
            obstacle.removeFromParent()
        }
        obstacles.removeAll()
        
        if scoreText != nil {
            scoreText?.removeFromParent()
            scoreText = nil
        }
        createAndAddGameOverText()
    }
    
    func startGame() {
        gameOverText?.removeFromParent()
        gameOverText = nil
        score = 0
        cameraNode.position = CGPoint(x: 0, y: 0)

        //Add Player
        createAndAddPlayer()
        
        //Add Floor
        createAndAddFloor()
        
        //Add Score
        createAndAddScore()
        
        //AddFirst Obstacles
        for _ in (0..<3) {
            createAndAddObstacle()
        }
    }
}


extension GameScene: SKPhysicsContactDelegate {
    
    override func didMove(to view: SKView) {
        //Quand on passe sur cette scene
        
        //CreatePhysics
        physicsWorld.contactDelegate = self
        physicsWorld.gravity.dy = -5
        
        //SetupCamera
        camera = cameraNode
        addChild(cameraNode)
        
        startGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Quand l'utilisateur touche l'écran
        
        //Make it jump
        if (player != nil) {
            player?.jump()
        }
        
        //Restart
        if gameOverText != nil {
            startGame()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Qand les sprites se mettent à jour
        
        //Vérifier que le joueur existe
        guard let playerPosition = player?.position.y else { return }
        //Suivre joueur
        if playerPosition > 0 {
            cameraNode.position.y = playerPosition
        }
        
        //Obstacle passé
        if playerPosition > 500 * CGFloat(obstacles.count - 2) + 200 {
            score += 1
            scoreText?.updateText(string: "\(score)")
            player?.changeColor()
            createAndAddObstacle()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //Quand il y a un contact avec les éléments
        guard let nodeA = contact.bodyA.node as? SKShapeNode else { return }
        guard let nodeB = contact.bodyB.node as? SKShapeNode else { return }
        guard nodeA.fillColor != nodeB.fillColor else { return }
        //GameOver
        gameOver()
    }
    
}
