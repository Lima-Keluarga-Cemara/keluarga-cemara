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
    let radius : Float = 15.0
    @Binding var sceneObject : SCNScene?
    //     try to add this with calculate shadow
    @Binding var azimuthAngle : Double
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView(frame: .zero)
        view.allowsCameraControl = true
        view.backgroundColor = .clear
        view.autoenablesDefaultLighting = true
        let fm = FileManager.default
        let path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "room.usdz"
        //        let modelFilePath  = path.appendingPathComponent(fileName).absoluteString
        _  = path.appendingPathComponent(fileName).absoluteString
        
        DispatchQueue.main.async {
            do {
                //                let scene = try? SCNScene(url: URL(string: "\(modelFilePath)")!)
                
                //               try with dummy data first
                view.scene = sceneObject
                let sceneNode = SCNNode(geometry: sceneObject?.rootNode.geometry)
                let lightNode = setUpLightShadow()
                sceneNode.geometry?.materials
                
                let constraint = SCNLookAtConstraint(target: sceneNode )
                constraint.isGimbalLockEnabled = true
                lightNode.constraints = [constraint]
                
                view.scene?.rootNode.addChildNode(lightNode)
                
                
            }
        }
        
        return view
        
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
        let position = getXYZPosition()
        uiView.scene?.rootNode.childNode(withName: "lightNode", recursively: false)?.position = SCNVector3(x: Float(position.x), y: Float(position.y), z:Float(position.z))
    }
    
    
    
    func setUpLightShadow() -> SCNNode{
        let light = SCNLight()
        light.type = .directional
        light.castsShadow = true
        light.shadowMode = .modulated
        light.intensity = 3000
        
        let pos = getXYZPosition()
        
        let lightNode = SCNNode()
        lightNode.name = "lightNode"
        lightNode.light = light
        lightNode.position = SCNVector3(x: Float(pos.x), y: Float(pos.y), z:Float(pos.z))
        lightNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: -.pi / 2)
        
        return lightNode
    }
    
    //     func for position
    func getXYZPosition() -> (x: Double, y : Double, z : Double){
        let azimuthRadians = azimuthAngle
        let x = Double(radius) * cos(azimuthRadians)
        let y : Double = 10.0
        let z = Double(radius) * sin(azimuthRadians)
        
        return (x,y,z)
    }
    
    
    
}
