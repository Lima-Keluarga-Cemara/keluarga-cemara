////
////  ViewController+ARSCNViewDelegate.swift
////  keluarga-cemara
////
////  Created by Muhammad Afif Maruf on 11/11/23.
////
//
//import ARKit
//import SwiftUI
//
//extension ViewController {
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//        self.focusNode.updateFocusNode()
//    }
//    
//    //Override to create and configure nodes for anchors added to the view's session.
//    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//        let node = SCNNode()
//        if let planeAnchor = anchor as? ARPlaneAnchor {
//            
//            if planeAnchor.alignment == .horizontal {
//                let plane = SCNPlane(width: CGFloat(planeAnchor.planeExtent.width), height: CGFloat(planeAnchor.planeExtent.height))
//                let planeNode = SCNNode(geometry: plane)
//                createHostingController(for: planeNode)
//                node.addChildNode(planeNode)
//            }
//            print("On Trackingg...")
//        }
//        
//        return node
//    }
//    
////    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
////        guard let planeAnchor = anchor as?  ARPlaneAnchor,
////              
////            let planeNode = node.childNodes.first,
////            let plane = planeNode.geometry as? SCNPlane
////            else { return }
////        
////        let width = CGFloat(planeAnchor.planeExtent.width)
////        let height = CGFloat(planeAnchor.planeExtent.height)
////        plane.width = width
////        plane.height = height
////        let annatationNode = SCNNode(geometry: plane)
////          createHostingController(for: annatationNode)
////        print("node ke update")
////        node.addChildNode(annatationNode)
////
////    }
//    
//
//    
//    func createHostingController(for node: SCNNode) {
//        print("Data masuk hosting controller ")
//        DispatchQueue.main.async {
//            let arVC = UIHostingController(rootView: InformationShadeView())
//            
//            arVC.willMove(toParent: self)
//            self.addChild(arVC)
//            arVC.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
//            self.view.addSubview(arVC.view)
//            self.show(hostingVC: arVC, on: node)
//        }
//    }
//    
//    func show(hostingVC: UIHostingController<InformationShadeView>, on node: SCNNode) {
//        let material = SCNMaterial()
//        hostingVC.view.isOpaque = false
//        material.diffuse.contents = hostingVC.view
//        node.geometry?.materials = [material]
//        hostingVC.view.backgroundColor = UIColor.clear
//    }
//   
//}
