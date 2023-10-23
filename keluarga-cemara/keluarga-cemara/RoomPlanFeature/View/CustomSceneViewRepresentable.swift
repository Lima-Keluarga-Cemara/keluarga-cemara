//
//  CustomSceneViewRepresentable.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 20/10/23.
//

import SwiftUI
import SceneKit

struct CustomSceneViewRepresentable : UIViewRepresentable{
    @Binding var isLoading : Bool
    var lightValue : Float
    let radius : Float = 15.0
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = true
        view.backgroundColor = .clear
        view.autoenablesDefaultLighting = true
        let fm = FileManager.default
        let path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "room.usdz"
        let modelFilePath  = path.appendingPathComponent(fileName).absoluteString
        DispatchQueue.main.async {
            do {
                let scene = try? SCNScene(url: URL(string: "\(modelFilePath)")!)
                view.scene = scene
            }
        }
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let fm = FileManager.default
        let path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "room.usdz"
        let modelFilePath  = path.appendingPathComponent(fileName).absoluteString
        DispatchQueue.main.async {
            do {
//                let scene = try? SCNScene(url: URL(string: "\(modelFilePath)")!)
//                add sceneNode
                let scene = SCNScene(named: "scan.usdz")
                let sceneNode = SCNNode(geometry: scene?.rootNode.geometry)
                let greenMaterial = SCNMaterial()
                greenMaterial.diffuse.contents =  UIColor.green
                scene?.rootNode.geometry?.materials = [greenMaterial]
                
                uiView.scene = scene
                
                let lightNode = setUpLightShadow()
//                let planeNode = setUpPlanet()
                let cameraNode = setUpCamera()
                
                let constraint = SCNLookAtConstraint(target: sceneNode )
                constraint.isGimbalLockEnabled = true
                cameraNode.constraints = [constraint]
                lightNode.constraints = [constraint]
                sceneNode.constraints = [constraint]
                
                scene?.rootNode.addChildNode(sceneNode)
                scene?.rootNode.addChildNode(cameraNode)
                scene?.rootNode.addChildNode(lightNode)
//                scene?.rootNode.addChildNode(planeNode)
                
            }
        }
    }
    
    func setUpCamera() -> SCNNode{
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: -2.0, y: 4.0, z: 4.0)
        
        return cameraNode
    }
    
    func setUpLightShadow() -> SCNNode{
        let light = SCNLight()
        light.type = .directional
//        light.spotInnerAngle = 30
//        light.spotOuterAngle = 80
        light.castsShadow = true
//        light.shadowMode = .deferred
        light.intensity = 3000
        
        let pos = getXYZPosition()
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x: pos.x, y: pos.y, z: pos.z)
        lightNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: -.pi / 2)
        
        return lightNode
    }
    
//     func for position
    func getXYZPosition() -> (x: Float, y : Float, z : Float){
        let angle = lightValue
        let x = radius * cos(angle)
        let y : Float = 10.5
        let z = radius * sin(angle)
        
        return (x,y,z)
    }
    
//    func for setup planet
//    func setUpPlanet() -> SCNNode{
//        let planeGeometry = SCNPlane(width: 50, height: 50)
//        let planeNode = SCNNode(geometry: planeGeometry)
//        planeNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(-90), y: 0, z: 0)
//        planeNode.position = SCNVector3(x: 0, y: -1.7, z: 0)
//        
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.systemPink
//        planeGeometry.materials = [material]
//        return planeNode
//        
//    }
}
