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
    
    func removeAllExistingNode(){
        // Ensure that the parentNode is not nil
        guard parentNode.childNodes.count > 0 else { return }
        
        // Remove all child nodes from the parent node
        parentNode.childNodes.forEach { $0.removeFromParentNode() }
        
        print("Removed all existing nodes")
    }
    
    func distanceBetween(node1: SCNNode, node2: SCNNode) -> Float {
        let distanceVector = SCNVector3Make(
            node2.position.x - node1.position.x,
            node2.position.y - node1.position.y,
            node2.position.z - node1.position.z
        )
        return sqrtf(distanceVector.x * distanceVector.x + distanceVector.y * distanceVector.y + distanceVector.z * distanceVector.z)
    }
    
    func createTextNode(text: String) -> SCNNode {
        let textGeometry = SCNText(string: text, extrusionDepth: 0.1)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode(geometry: textGeometry)
        textNode.scale = SCNVector3(0.01, 0.01, 0.01) // Adjust the scale as needed
        
        return textNode
    }
    
    func formatDistanceWithCommas(distance: Float) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2 // Set the desired number of decimal places
        
        return numberFormatter.string(from: NSNumber(value: distance)) ?? "\(distance)"
    }
    
    func createDotGeometry(_ hitTest: SCNHitTestResult) -> SCNNode {
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
    
    func createLineAndTextNode() -> (SCNNode, SCNNode){
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
