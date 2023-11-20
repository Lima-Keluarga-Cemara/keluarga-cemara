//
//  SceneCoordinator.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 20/11/23.
//

import Foundation
import SceneKit
import SwiftUI

class Coordinator: NSObject {
    var resultVM: SceneKitViewModel
    
    init(_ resultVM: SceneKitViewModel) {
        self.resultVM = resultVM
    }
    
    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        if self.resultVM.isActiveGesture{
            let currentTapLocation = gestureRecognize.location(in: self.resultVM.sceneView)
            guard let hitTest = self.resultVM.sceneView.hitTest(currentTapLocation, options: nil).first else { return }
            
            // Check if the hit test result has a SCNNode associated with it
            self.resultVM.parentNode = hitTest.node
            // Check if parent child node more than two
            let isParentChildNodeMoreThanTwo: () -> Bool = {
                return self.resultVM.parentNode.childNodes.count >= 2
            }
            
            if isParentChildNodeMoreThanTwo() {
                // If there are 2 or more child nodes, remove all existing nodes
                self.resultVM.removeAllExistingNode()
            }
            let dotNode = self.resultVM.createDotGeometry(hitTest)
            
            // Add the sphere node to the parent node or the scene as needed
            self.resultVM.parentNode.addChildNode(dotNode)
            
            // Create a line geometry between two child nodes
            if isParentChildNodeMoreThanTwo() {
                let (lineNode, textNode) = self.resultVM.createLineAndTextNode()
                // Add the line node to the parent node or the scene as needed
                self.resultVM.parentNode.addChildNode(lineNode)
                self.resultVM.parentNode.addChildNode(textNode)
                
                // Apply billboard constraint to the text node
                let billboardConstraint = SCNBillboardConstraint()
                textNode.constraints = [billboardConstraint]
            }
        }
    }
    
    
}
