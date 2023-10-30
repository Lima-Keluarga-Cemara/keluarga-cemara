//
//  LightFeatures.swift
//  ExploringSceneKit
//
//  Created by Fabrizio Duroni on 26.08.17.
//

import SceneKit
//
//class LightFeatures {
//    let position: SCNVector3
//    var orientation: SCNVector3
//    let color: UIColor
//    
//    init(position: SCNVector3, orientation: SCNVector3, color: UIColor) {
//        self.position = position
//        self.orientation = orientation
//        self.color = color
//    }
//}

class LightFeatures {
    var position: SCNVector3
    var orientation: SCNVector3
    var color: UIColor
    
    init(position: SCNVector3, orientation: SCNVector3, color: UIColor) {
        self.position = position
        self.orientation = orientation
        self.color = color
    }
    
    func updateOrientation(newOrientation_x: Float, newOrientation_y: Float) {
        orientation = SCNVector3Make(
            GLKMathDegreesToRadians(newOrientation_x),
            GLKMathDegreesToRadians(newOrientation_y),
            0
        )
    }
}
