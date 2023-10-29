//
//  ViewController.swift
//  SceneUiKit
//
//  Created by M Yogi Satriawan on 26/10/23.
//

import SwiftUI
import ARKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.delegate = context.coordinator
        arView.showsStatistics = true
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        arView.scene = scene
        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, ARSCNViewDelegate {
        func session(_ session: ARSession, didFailWithError error: Error) {
            // Handle error
        }

        func sessionWasInterrupted(_ session: ARSession) {
            // Handle interruption
        }

        func sessionInterruptionEnded(_ session: ARSession) {
            // Handle interruption end
        }
    }
}
