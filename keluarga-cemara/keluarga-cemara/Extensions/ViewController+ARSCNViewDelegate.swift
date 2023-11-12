//
//  ViewController+ARSCNViewDelegate.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 11/11/23.
//

import ARKit

extension ViewController {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        self.focusNode.updateFocusNode()
    }
    
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        print("Add")
//        guard let planeAnchor = anchor as? ARPlaneAnchor else{return }
//        self.createPlane(planeAnchor: planeAnchor, node: node)
//    }
//    
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        guard let planeAnchor = anchor as? ARPlaneAnchor else{return }
////        print(planeAnchor.center)
////        print(planeAnchor.planeExtent)
//        self.updatePlane(planeAnchor: planeAnchor, node: node)
//    }
//    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
//        node.enumerateChildNodes { childNode, _ in
//            childNode.removeFromParentNode()
//        }
//        
//    }
//    
//    func createPlane(planeAnchor : ARPlaneAnchor, node : SCNNode){
//        let planeGeomentry = SCNPlane(width: CGFloat(planeAnchor.planeExtent.width), height: CGFloat(planeAnchor.planeExtent.height))
//        planeGeomentry.materials.first?.diffuse.contents = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 0.6022350993)
//        planeGeomentry.materials.first?.isDoubleSided = true
//        let planeNode = SCNNode(geometry: planeGeomentry)
//        planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0.0, z: planeAnchor.center.z)
//        planeNode.eulerAngles = SCNVector3(x: Float(Double.pi) / 2, y: 0, z: 0)
//        node.addChildNode(planeNode)
//    }
//    
//    func updatePlane(planeAnchor: ARPlaneAnchor, node: SCNNode){
//        if let planeNode = node.childNodes.first{
//            if let planeGeomentry = node.childNodes.first?.geometry as? SCNPlane{
//                planeGeomentry.width = CGFloat(planeAnchor.planeExtent.width)
//                planeGeomentry.height = CGFloat(planeAnchor.planeExtent.height)
//                planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0.0, z: planeAnchor.center.z)
//            }
//        }
//    }
}
