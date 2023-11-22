//
//  ObjViewController.swift
//  SceneUiKit
//
//  Created by M Yogi Satriawan on 27/10/23.


import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable {
    @ObservedObject var lightPosition: LightPosition
    @ObservedObject var resultVM: SceneKitViewModel
    var scene: PhysicallyBasedScene
    
    func makeUIView(context: Context) -> SCNView {
        resultVM.sceneView.scene = scene
        resultVM.sceneView.autoenablesDefaultLighting = true
        resultVM.sceneView.allowsCameraControl = true
        
        /// Setup Tap Recognizer
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
        resultVM.sceneView.addGestureRecognizer(tapGesture)
        
        return resultVM.sceneView
    }
    
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        let orientations = getXYZOrientation()
        let firstOrientation = orientations[0]
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            uiView.scene?.rootNode.childNode(withName: "Light", recursively: false)?.eulerAngles = SCNVector3(firstOrientation.x, firstOrientation.y, firstOrientation.z)
            
        }
        
        uiView.antialiasingMode = .multisampling4X
        uiView.autoenablesDefaultLighting = true
        uiView.allowsCameraControl = true
//        resultVM.scaleAllTextNodesBasedOnFOV(uiView)
    }
    
    func getXYZOrientation() -> [SCNVector3] {
        var orientations: [SCNVector3] = []
        
        for i in 0..<6 {
            let x = lightPosition.orientation_x[i]
            let y = lightPosition.orientation_y[i]
            let z = lightPosition.orientation_z[i]
            let orientation = SCNVector3(x, y, z)
            orientations.append(orientation)
        }
        
        return orientations
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(resultVM)
    }
    
}
