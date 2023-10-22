//
//  SceneArea.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 20/10/23.
//

import SwiftUI
import SceneKit

struct SceneAreaViewWrapper: UIViewRepresentable {
    var lightValue: Float
    let radius: Float = 15.0
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.allowsCameraControl = true
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // Set up your 3D scene here
        let scene = SCNScene()
        uiView.scene = scene
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(-2.0, 4.0, 4.0)
        
        // setup camera light
        let ambientLight = setupCameraLight()
        cameraNode.light = ambientLight
        
        // setup all
        let lightNode = setupLightCore()
        let objectNode = setupObject()
        let planeNode = setupPlane()
        let constraint = setupConstraintLook(for: objectNode)
        // setup constraint
        cameraNode.constraints = [constraint]
        lightNode.constraints = [constraint]
        
        // add to scene
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(objectNode)
        scene.rootNode.addChildNode(planeNode)
    }
    
    func setupCameraLight() -> SCNLight {
        let ambientLight = SCNLight()
        ambientLight.type = SCNLight.LightType.ambient
        ambientLight.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        return ambientLight
    }
    
    func setupLightCore() -> SCNNode {
        //setup light
        let light = SCNLight()
        light.type = SCNLight.LightType.directional
        light.castsShadow = true
        light.shadowMode = .deferred
        light.intensity = 4000
        
        let pos = getXYZPosistion()
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(pos.x, pos.y, pos.z)
        lightNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: -.pi / 2)
        
        return lightNode
    }
    
    func setupObject() -> SCNNode{
        let cubeGeometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        let cubeNode = SCNNode(geometry: cubeGeometry)
        
        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = UIColor.red
        cubeGeometry.materials = [redMaterial]
        
        return cubeNode
    }
    
    func setupPlane() -> SCNNode{
        let planeGeometry = SCNPlane(width: 50.0, height: 50.0)
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(-90), y: 0, z: 0)
        planeNode.position = SCNVector3(x: 0, y: -0.5, z: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white
        planeGeometry.materials = [material]
        
        return planeNode
    }
    
    func setupConstraintLook(for objectNode: SCNNode) -> SCNLookAtConstraint {
        let constraint = SCNLookAtConstraint(target: objectNode)
        constraint.isGimbalLockEnabled = true
        
        return constraint
    }
    
    func getXYZPosistion() -> (x: Float, y: Float, z: Float){
        let angle = lightValue
        let x = radius * cos(angle)
        let y: Float = 10.5  // Adjust as needed
        let z = radius * sin(angle)
        
        return (x, y, z)
    }
    
    func loadDragonModel() {
        
    }
    
}
