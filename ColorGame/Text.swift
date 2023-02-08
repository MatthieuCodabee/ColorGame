//
//  Text.swift
//  ColorGame
//
//  Created by matthieu passerel on 08/02/2023.
//

import SpriteKit

class Text: SKLabelNode {
    
    func setup(position: CGPoint, size: CGFloat) {
        self.position = position
        fontName = "Helvetica Neue"
        fontColor = .white
        fontSize = size
        numberOfLines = 3
    }
    
    func updateText(string: String) {
        text = string
    }
}
