//
//  Coordinator+Extension.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 22/11/23.
//

import Foundation
import SceneKit

extension Coordinator {
    
    func autoScaleTextNode(named nodeName: String, sceneView: SCNView) {
        guard let pointOfView = sceneView.pointOfView,
                let textNode = sceneView.scene?.rootNode.childNode(withName: nodeName, recursively: false) else { return }
        
        print("[DEBUG][TextNode]", textNode.position)
        
        let distance = distanceBetween(pointOfView.worldPosition, textNode.worldPosition)
        let scaleFactor = calculateScaleFactor(distance: distance)
        
        textNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
    }
    
    private func distanceBetween(_ position1: SCNVector3, _ position2: SCNVector3) -> Float {
        let dx = position2.x - position1.x
        let dy = position2.y - position1.y
        let dz = position2.z - position1.z
        
        return sqrt(dx*dx + dy*dy + dz*dz)
    }
    
    private func calculateScaleFactor(distance: Float) -> Float {
        // You can customize this scaling logic based on your specific requirements.
        // This is just a simple example, adjust it as needed.
        let maxDistance: Float = 10.0
        let minScale: Float = 0.1
        let maxScale: Float = 1.0
        
        let scaleFactor = max(minScale, 1 - (distance / maxDistance))
        return min(maxScale, scaleFactor)
    }
}
