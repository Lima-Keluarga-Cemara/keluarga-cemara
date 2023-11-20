//
//  SceneCoordinator.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 20/11/23.
//

import Foundation
import SceneKit

class Coordinator: NSObject {
    var parent: SCNView
    private var placedNodes: [SCNNode] = []
    
    init(_ parent: SCNView) {
        self.parent = parent
    }
    
    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let currentTapLocation = gestureRecognize.location(in: self.parent)
        guard let hitTest = self.parent.hitTest(currentTapLocation, options: nil).first else { return }
        
        // Check if the hit test result has a SCNNode associated with it
        let parentNode = hitTest.node
        // Check if parent child node more than two
        let isParentChildNodeMoreThanTwo: () -> Bool = {
            return parentNode.childNodes.count >= 2
        }
        
        if isParentChildNodeMoreThanTwo() {
            // If there are 2 or more child nodes, remove all existing nodes
            removeAllExistingNode(parentNode)
        }
        let dotNode = createDotGeometry(hitTest)
        
        // Add the sphere node to the parent node or the scene as needed
        parentNode.addChildNode(dotNode)
        placedNodes.append(dotNode)
        
        // Create a line geometry between two child nodes
        if isParentChildNodeMoreThanTwo() {
            let (lineNode, textNode) = createLineAndTextNode(parentNode)
            // Add the line node to the parent node or the scene as needed
            parentNode.addChildNode(lineNode)
            parentNode.addChildNode(textNode)
            
            // Apply billboard constraint to the text node
            let billboardConstraint = SCNBillboardConstraint()
            textNode.constraints = [billboardConstraint]
        }
    }
    
    private func removeLastPlacedNode(_ parentNode: SCNNode) {
        // Ensure there are placed nodes to remove
        guard !placedNodes.isEmpty else { return }
        
        let lastNode = placedNodes.removeLast()
        lastNode.removeFromParentNode()
        print("Removed the last placed node")
    }
    
    private func distanceBetween(node1: SCNNode, node2: SCNNode) -> Float {
        let distanceVector = SCNVector3Make(
            node2.position.x - node1.position.x,
            node2.position.y - node1.position.y,
            node2.position.z - node1.position.z
        )
        return sqrtf(distanceVector.x * distanceVector.x + distanceVector.y * distanceVector.y + distanceVector.z * distanceVector.z)
    }
    
    private func createTextNode(text: String) -> SCNNode {
        let textGeometry = SCNText(string: text, extrusionDepth: 0.1)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode(geometry: textGeometry)
        textNode.scale = SCNVector3(0.01, 0.01, 0.01) // Adjust the scale as needed
        
        return textNode
    }
    
    private func formatDistanceWithCommas(distance: Float) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2 // Set the desired number of decimal places
        
        return numberFormatter.string(from: NSNumber(value: distance)) ?? "\(distance)"
    }
    
    private func removeAllExistingNode(_ parentNode: SCNNode){
        // Ensure that the parentNode is not nil
        guard parentNode.childNodes.count > 0 else { return }
        
        // Remove all child nodes from the parent node
        parentNode.childNodes.forEach { $0.removeFromParentNode() }
        
        print("Removed all existing nodes")
    }
    
    private func createDotGeometry(_ hitTest: SCNHitTestResult) -> SCNNode{
        // Create a sphere geometry
        let sphereGeometry = SCNSphere(radius: 0.05) // You can adjust the radius as needed
        
        // Create a material for the sphere (you can customize the appearance)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue // Set the color of the sphere
        
        // Apply the material to the sphere
        sphereGeometry.materials = [material]
        
        // Create a new SCNNode with the sphere geometry
        let sphereNode = SCNNode(geometry: sphereGeometry)
        
        // Set the position of the sphere node based on the hit test result
        sphereNode.position = hitTest.localCoordinates
        
        return sphereNode
    }
    
    private func createLineAndTextNode(_ parentNode: SCNNode) -> (SCNNode, SCNNode){
        let firstNode = parentNode.childNodes[0]
        let secondNode = parentNode.childNodes[1]
        
        // Calculate the midpoint between the two nodes
        let midpoint = SCNVector3Make(
            (firstNode.position.x + secondNode.position.x) / 2,
            (firstNode.position.y + secondNode.position.y) / 2,
            (firstNode.position.z + secondNode.position.z) / 2
        )
        
        // Create a line geometry with the positions of the two nodes
        let lineGeometry = SCNGeometry.lineFrom(vector: firstNode.position, toVector: secondNode.position)
        
        // Create a material for the line (you can customize the appearance)
        let lineMaterial = SCNMaterial()
        lineMaterial.diffuse.contents = UIColor.red // Set the color of the line
        
        // Apply the material to the line
        lineGeometry.materials = [lineMaterial]
        
        // Calculate the distance between the two nodes
        let distance = distanceBetween(node1: firstNode, node2: secondNode)
        
        // Format the distance with commas
        let formattedDistance = formatDistanceWithCommas(distance: distance)
        
        // Create a new SCNNode with the line geometry
        let lineNode = SCNNode(geometry: lineGeometry)
        // Display the distance as text at the midpoint
        let textNode = createTextNode(text: "\(formattedDistance) meters")
        textNode.position = midpoint
        
        print("Distance between nodes: \(distance) meters")
        
        return (lineNode, textNode)
    }
}
