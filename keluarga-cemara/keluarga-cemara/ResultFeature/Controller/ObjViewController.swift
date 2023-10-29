//
//  ObjViewController.swift
//  SceneUiKit
//
//  Created by M Yogi Satriawan on 27/10/23.
//
import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable {
    let scene: PhysicallyBasedScene
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // You can add any additional updates here if needed
    }
}


