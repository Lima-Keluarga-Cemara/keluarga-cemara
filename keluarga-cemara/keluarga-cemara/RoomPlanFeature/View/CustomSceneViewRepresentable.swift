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
    var lightValue : Double
    let radius : Float = 15.0
    @Binding var sceneObject : SCNScene?
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView(frame: .zero)
        view.allowsCameraControl = true
        view.backgroundColor = .clear
        view.autoenablesDefaultLighting = true
        let fm = FileManager.default
        let path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "room.usdz"
        let modelFilePath  = path.appendingPathComponent(fileName).absoluteString
        
        let lightNode = setUpLightShadow()
        
        DispatchQueue.main.async {
            do {
//                let scene = try? SCNScene(url: URL(string: "\(modelFilePath)")!)
                view.scene = sceneObject
                let sceneNode = SCNNode(geometry: sceneObject?.rootNode.geometry)
                let constraint = SCNLookAtConstraint(target: sceneNode )
                constraint.isGimbalLockEnabled = true
                lightNode.constraints = [constraint]
                sceneObject?.rootNode.addChildNode(lightNode)
                
            }
        }
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        let lightNode = setUpLightShadow()
        let sceneNode = SCNNode(geometry: sceneObject?.rootNode.geometry)
        let constraint = SCNLookAtConstraint(target: sceneNode)
        constraint.isGimbalLockEnabled = true
        lightNode.constraints = [constraint]
        
        sceneObject?.rootNode.addChildNode(lightNode)
    
    }
        
    func setUpLightShadow() -> SCNNode{
        let light = SCNLight()
        light.type = .directional
        light.castsShadow = true
        light.shadowMode = .modulated
        light.intensity = 3000
        
        let pos = getXYZPosition()
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x: Float(pos.x), y: Float(pos.y), z:Float(pos.z))
        lightNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: -.pi / 2)
        
        return lightNode
    }
    
//     func for position
    func getXYZPosition() -> (x: Double, y : Double, z : Double){
        let angle = lightValue
        let x = Double(radius) * cos(angle)
        let y : Double = 10.5
        let z = Double(radius) * sin(angle)
        
        return (x,y,z)
    }
    
}
