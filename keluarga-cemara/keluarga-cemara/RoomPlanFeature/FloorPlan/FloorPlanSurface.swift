//
//  FloorPlanSurface.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 18/11/23.
//

import Foundation

import RoomPlan
import SceneKit


class FloorPlanSurface: SCNNode {
    
    private let capturedSurface: CapturedRoom.Surface
    
    // MARK: - Computed properties
    
    private var halfLength: CGFloat {
        return CGFloat(capturedSurface.dimensions.x) * scalingFactor / 2
    }
    
    private var pointA: SCNVector3 {
        return SCNVector3(-halfLength, 0, 0)
    }
    
    private var pointB: SCNVector3 {
        return SCNVector3(halfLength, 0, 0)
    }
    
    private var pointC: SCNVector3 {
        return pointB.rotateAround(axis: SCNVector3(0, 1, 0), by: SCNFloat(0.25 * .pi))
    }
    
    // MARK: - Init
    
    init(capturedSurface: CapturedRoom.Surface) {
        self.capturedSurface = capturedSurface
        
        super.init()
        
        // Set the surface's position using the transform matrix
        let surfacePositionX = -CGFloat(capturedSurface.transform.position.x) * scalingFactor
        let surfacePositionY = CGFloat(capturedSurface.transform.position.z) * scalingFactor
        self.position = SCNVector3(surfacePositionX, surfacePositionY, 0)
        
        // Set the surface's zRotation using the transform matrix
        self.eulerAngles.z = SCNFloat(-capturedSurface.transform.eulerAngles.z + capturedSurface.transform.eulerAngles.y)
        
        
        if capturedSurface.category == .wall {
            drawWall()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Draw
    
    private func drawDoor() {
        let hideWallGeometry = SCNShape(path: createPath(from: pointA, to: pointB), extrusionDepth: hideSurfaceWith)
        let hideWallNode = SCNNode(geometry: hideWallGeometry)
        hideWallNode.geometry?.firstMaterial?.diffuse.contents = floorPlanBackgroundColor
        hideWallNode.position.z = hideSurfaceZPosition
        
        let doorGeometry = SCNShape(path: createPath(from: pointA, to: pointC), extrusionDepth: surfaceWith)
        let doorNode = SCNNode(geometry: doorGeometry)
        doorNode.position.z = doorZPosition
        
        let doorArcPath = UIBezierPath(arcCenter: CGPoint(x: CGFloat(pointA.x), y: CGFloat(pointA.y)), radius: CGFloat(halfLength * 2), startAngle: 0.25 * .pi, endAngle: 0, clockwise: true)

        let dashedArcGeometry = SCNShape(path: doorArcPath.cgPath.copy(dashingWithPhase: 1, lengths: [24.0, 8.0]) as? UIBezierPath, extrusionDepth: doorArcWidth)
        
        let doorArcNode = SCNNode(geometry: dashedArcGeometry)
        doorArcNode.position.z = doorArcZPosition
        
        addChildNode(hideWallNode)
        addChildNode(doorNode)
        addChildNode(doorArcNode)
    }
    
    private func drawOpening() {
        let openingGeometry = SCNShape(path: createPath(from: pointA, to: pointB), extrusionDepth: hideSurfaceWith)
        let openingNode = SCNNode(geometry: openingGeometry)
        openingNode.geometry?.firstMaterial?.diffuse.contents = floorPlanBackgroundColor
        openingNode.position.z = hideSurfaceZPosition
        
        addChildNode(openingNode)
    }
    
    private func drawWall() {
        let wallGeometry = SCNShape(path: createPath(from: pointA, to: pointB), extrusionDepth: surfaceWith)
        let wallNode = SCNNode(geometry: wallGeometry)
        wallNode.geometry?.firstMaterial?.diffuse.contents = floorPlanSurfaceColor
        
        // Create 3D text node for wall length
        let wallLength = capturedSurface.dimensions.x
        let formattedLength = String(format: "%.2f", wallLength)
        let wallLengthText = "\(formattedLength) m"
        let wallLengthTextNode = create3DTextNode(text: wallLengthText, position: SCNVector3((pointA.x + pointB.x) / 2, (pointA.y + pointB.y) / 2, 20))
        
        addChildNode(wallNode)
        addChildNode(wallLengthTextNode)
    }

    private func create3DTextNode(text: String, position: SCNVector3) -> SCNNode {
        let textGeometry = SCNText(string: text, extrusionDepth: 2.0)
        textGeometry.font = UIFont.systemFont(ofSize: 24)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.black
        
        let textNode = SCNNode(geometry: textGeometry)
        textNode.position = position
        
        return textNode
    }
    
    private func drawWindow() {
        let windowGeometry = SCNShape(path: createPath(from: pointA, to: pointB), extrusionDepth: hideSurfaceWith)
        let windowHideNode = SCNNode(geometry: windowGeometry)
        windowHideNode.geometry?.firstMaterial?.diffuse.contents = floorPlanBackgroundColor
        windowHideNode.position.z = hideSurfaceZPosition
        
        let windowGeometryActual = SCNShape(path: createPath(from: pointA, to: pointB), extrusionDepth: windowWidth)
        let windowNode = SCNNode(geometry: windowGeometryActual)
        windowNode.position.z = windowZPosition
        
        addChildNode(windowHideNode)
        addChildNode(windowNode)
    }
    
    // MARK: - Helper functions
    
    private func createPath(from pointA: SCNVector3, to pointB: SCNVector3) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: Double(pointA.x), y: Double(pointA.y)))
        path.addLine(to: CGPoint(x: Double(pointB.x), y: Double(pointB.y)))
        
        return path
    }
}
