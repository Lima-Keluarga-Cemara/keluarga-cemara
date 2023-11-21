//
//  SceneKitViewAll.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 20/11/23.
//

//import SwiftUI
//import SceneKit
//
//struct SceneKitViewAll: UIViewRepresentable {
//    @ObservedObject var lightPosition: LightPosition
//    var scene: PhysicallyBasedScene
//
//    func makeUIView(context: Context) -> SCNView {
//        let sceneView = SCNView(frame: .zero)
//        sceneView.scene = scene
//        sceneView.autoenablesDefaultLighting = true
//        sceneView.allowsCameraControl = true
//        return sceneView
//    }
//
//
//    func updateUIView(_ uiView: SCNView, context: Context) {
//        let orientations = getXYZOrientation()
//        let firstOrientation = orientations[0]
//
//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
//            uiView.scene?.rootNode.childNode(withName: "Light", recursively: false)?.eulerAngles = SCNVector3(firstOrientation.x, firstOrientation.y, firstOrientation.z)
//
//        }
//
//        uiView.antialiasingMode = .multisampling4X
//        uiView.autoenablesDefaultLighting = true
//        uiView.allowsCameraControl = true
//        if let recognizers = uiView.gestureRecognizers {
//            for recognizer in recognizers {
//                recognizer.isEnabled = false
//            }
//        }
//
//    }
//
//
//
//    func getXYZOrientation() -> [SCNVector3] {
//        var orientations: [SCNVector3] = []
//        let x = lightPosition.orientation_x[0]
//        let y = lightPosition.orientation_y[0]
//        let z = lightPosition.orientation_z[0]
//        let orientation = SCNVector3(x, y, z)
//        orientations.append(orientation)
//        print(orientation)
//
//
//        return orientations
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject {
//        var parent: SceneKitViewAll
//
//        init(_ parent: SceneKitViewAll) {
//            self.parent = parent
//        }
//    }
//}
