//
//  ContentView.swift
//  ColorGame
//
//  Created by matthieu passerel on 08/02/2023.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    func createScene(size: CGSize) -> GameScene {
        let scene = GameScene(size: size)
        scene.scaleMode = .aspectFit
        return scene
    }
    
    var body: some View {
        GeometryReader { geometryProxy in
            SpriteView(scene: createScene(size: geometryProxy.size))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
