//
//  SceneKitViewModel.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 20/11/23.
//

import SwiftUI
import SceneKit
import SunKit

class SceneKitViewModel: ObservableObject{
    @Published var parentNode: SCNNode = SCNNode()
    @Published var isActiveGesture: Bool = false
    @Published var sceneView = SCNView(frame: .zero)
    @Published var lightPosition = LightPosition()
    
    let date = Date()
    var calendar = Calendar.current
    let timeValue: [Double] = [06.00, 08.00, 10.00, 12.00, 13.00, 15.00, 17.00]
    
    var allTimeValueInCalender: [Date] {
        var allDates: [Date] = []
        for time in timeValue{
            var dateComponents = calendar.dateComponents([.year, .month, .day, .hour], from: date)
            dateComponents.hour = Int(time)
            if let newDate = calendar.date(from: dateComponents) {
                allDates.append(newDate)
            }
        }
        
        return allDates
    }
    
    func getAllSunPosition(from sun: Sun){
        for (index, date) in allTimeValueInCalender.enumerated(){
            let sunPosition = sun.getSunHorizonCoordinatesFrom(date: date)
            let sunAltitude = sunPosition.altitude
            let sunAzimuth = sunPosition.azimuth
            
            let r: Double = 1.0
            let theta: Double = sunAltitude.radians
            let phi: Double = sunAzimuth.radians
            
            let x = r * sin(theta) * cos(phi)
            let y = r * sin(theta) * sin(phi)
            let z = r * cos(theta)
            
            lightPosition.orientation_x[index] = Float(x)
            lightPosition.orientation_y[index] = Float(y)
            lightPosition.orientation_z[index] = Float(z)
        }
    }
    
    func changeActiveMesureGesture(){
        isActiveGesture.toggle()
        removeAllExistingNode()
    }
    
    func removeExistingNodeFromParentNode(){
        // Ensure that the parentNode is not nil
        guard parentNode.childNodes.count > 0 else { return }
        
        // Remove all child nodes from the parent node
        parentNode.childNodes.forEach { $0.removeFromParentNode() }
        
        print("Removed all existing nodes")
    }
    
    func removeAllExistingNode() {
        // Ensure that the scene is not nil
        guard let scene = sceneView.scene else { return }
        
        // Remove all child nodes from the root node of the scene
        removeExistingNodeByNameFromScene(scene.rootNode, "dotNode")
        removeExistingNodeByNameFromScene(scene.rootNode, "lineNode")
        removeExistingNodeByNameFromScene(scene.rootNode, "textNode")
        
        print("Removed all existing nodes from scene")
    }
    
    func removeExistingNodeByNameFromScene(_ node: SCNNode, _ name: String) {
        // Recursively search through all child nodes
        for childNode in node.childNodes {
            removeExistingNodeByNameFromScene(childNode, name)
        }
        
        // Remove nodes with the specified name
        node.childNodes.filter { $0.name == name }.forEach { $0.removeFromParentNode() }
    }
    
    
    func distanceBetween(node1: SCNNode, node2: SCNNode) -> Float {
        let distanceVector = SCNVector3Make(
            node2.position.x - node1.position.x,
            node2.position.y - node1.position.y,
            node2.position.z - node1.position.z
        )
        return sqrtf(distanceVector.x * distanceVector.x + distanceVector.y * distanceVector.y + distanceVector.z * distanceVector.z)
    }
    
    func formatDistanceWithCommas(distance: Float) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2 // Set the desired number of decimal places
        
        return numberFormatter.string(from: NSNumber(value: distance)) ?? "\(distance)"
    }
    
    func createTextNode(text: String) -> SCNNode {
        let textGeometry = SCNText(string: text, extrusionDepth: 0.1)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.black
        
        let textNode = SCNNode(geometry: textGeometry)
        textNode.scale = SCNVector3(0.025, 0.025, 0.025) // Adjust the scale as needed
        
        return textNode
    }
    
    func createCylinderLineNode(distance: CGFloat, startNode firstNode: SCNNode, endNode secondNode: SCNNode, halflength midpoint: SCNVector3) -> SCNNode{
        // Create a material for the line (you can customize the appearance)
        let lineMaterial = SCNMaterial()
        lineMaterial.diffuse.contents = UIColor.brown // Set the color of the line
        
        // Create a cylinder geometry
        let cylinderGeometry = SCNCylinder(radius: 0.02, height: CGFloat(distance))
        cylinderGeometry.materials = [lineMaterial]
        
        // Create a new SCNNode with the line geometry
        let lineNode = SCNNode(geometry: cylinderGeometry)
        lineNode.name = "lineNode"
        lineNode.position = midpoint
        
        // Calculate the direction vector between node1 and node2
        let direction = SCNVector3(secondNode.position.x - firstNode.position.x,
                                   secondNode.position.y - firstNode.position.y,
                                   secondNode.position.z - firstNode.position.z)
        
        // Calculate the angle between node1 and node2
        let length = sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
        let nodeAngleX = acos(direction.y / length) // Assuming Y-axis rotation
        let nodeAngleZ = atan2(direction.x, direction.z) // Assuming Z-axis rotation
        
        // Set the orientation of the lineNode based on node1 and node2 angles
        lineNode.eulerAngles.x = nodeAngleX
        lineNode.eulerAngles.y = nodeAngleZ
        
        return lineNode
    }
    
    func createDotGeometry(_ hitTest: SCNHitTestResult) -> SCNNode {
        // Create a sphere geometry
        let sphereGeometry = SCNSphere(radius: 0.05) // You can adjust the radius as needed
        
        // Create a material for the sphere (you can customize the appearance)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.brown // Set the color of the sphere
        
        // Apply the material to the sphere
        sphereGeometry.materials = [material]
        
        // Create a new SCNNode with the sphere geometry
        let sphereNode = SCNNode(geometry: sphereGeometry)
        
        // Set the position of the sphere node based on the hit test result
        sphereNode.position = hitTest.localCoordinates
        
        // Set a name for the sphere node
        sphereNode.name = "dotNode"
        
        return sphereNode
    }
    
    func createLineAndTextNode() -> (SCNNode, SCNNode){
        let firstNode = parentNode.childNodes[0]
        let secondNode = parentNode.childNodes[1]
        
        // Calculate the midpoint between the two nodes
        let midpoint = SCNVector3Make(
            (firstNode.position.x + secondNode.position.x) / 2,
            (firstNode.position.y + secondNode.position.y) / 2,
            (firstNode.position.z + secondNode.position.z) / 2
        )
        
        // Calculate the distance between the two nodes
        let distance = distanceBetween(node1: firstNode, node2: secondNode)
        
        // Format the distance with commas
        let formattedDistance = formatDistanceWithCommas(distance: distance)
        
        let lineNode = createCylinderLineNode(distance: CGFloat(distance), startNode: firstNode, endNode: secondNode, halflength: midpoint)
        
        // Display the distance as text at the midpoint
        let textNode = createTextNode(text: "\(formattedDistance) meters")
        textNode.name = "textNode"
        textNode.position = midpoint
        
        print("Distance between nodes: \(distance) meters")
        
        return (lineNode, textNode)
    }
    
    func scaleAllTextNodesBasedOnFOV(_ view: SCNView) {
        guard let fieldOfView = view.pointOfView?.camera?.fieldOfView else {
            return
        }
        
        var scale : CGFloat {
            fieldOfView  == 0 ? 0.01 : fieldOfView / 2400
        }
        
        view.scene?.rootNode.enumerateChildNodes { node, _ in
            if node.name == "textNode" {
                node.scale = SCNVector3(x: Float(scale), y: Float(scale), z: Float(scale))
            }
        }
    }
}

///   0 = 1
///   60 = 0.025
///   120 = 3
