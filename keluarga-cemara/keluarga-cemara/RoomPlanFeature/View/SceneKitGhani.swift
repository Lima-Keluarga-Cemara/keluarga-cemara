//
//  SceneKitGhani.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 26/10/23.
//

import Foundation

import SwiftUI
import SceneKit

struct KeyboardSceneView: UIViewRepresentable{
    @Binding var tappedNodeName: String?
    @Binding var scene: SCNScene?
    @Binding var isToggled: Bool
    @State var isType: Bool = false
    var sceneView = SCNView()
    
    func makeUIView(context: Context) -> SCNView {
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.antialiasingMode = .multisampling2X
        sceneView.backgroundColor = .clear
        sceneView.cameraControlConfiguration.rotationSensitivity = 0.3
        sceneView.cameraControlConfiguration.flyModeVelocity = 0.1
        sceneView.cameraControlConfiguration.panSensitivity = 0.1
        sceneView.cameraControlConfiguration.truckSensitivity = 0.1
        
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
                sceneView.addGestureRecognizer(tapGesture)
        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
      let initialPosition:Float = tappedNodeName != "KEY_A" ? 0 : -0.007
      let pressedPosition:Float = tappedNodeName != "KEY_A" ? -0.003 : -0.01
        uiView.scene = scene
//        let scale = 0.75
//        uiView.scene?.rootNode.position = SCNVector3(x: 0, y: 0, z: 0)
//        uiView.scene?.rootNode.scale = SCNVector3(scale, scale, scale)
        uiView.scene?.rootNode.eulerAngles.x = 0.5
        
        animateNode(withName: "__KEYCAPS", zPosition: isToggled ? 0.007 : 0.08, duration: 0.5, in: uiView)
        animateNode(withName: "__SWITCHES", zPosition: isToggled ? 0 : 0.035, duration: 0.5, in: uiView)
        animateNode(withName: "__PLATE", zPosition: isToggled ? -0.026 : -0.035, duration: 0.5, in: uiView)
        animateNode(withName: "__CASE", zPosition: isToggled ? -0.026 : -0.08, duration: 0.5, in: uiView)
      
        animateTyping(withName: tappedNodeName ?? "none", zPosition: isType ? pressedPosition : initialPosition, duration: 0.1, in: uiView)
    }

    func animateNode(withName name: String, zPosition: Float, duration: TimeInterval, in uiView: SCNView) {
        if let node = uiView.scene?.rootNode.childNode(withName: name, recursively: true) {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = duration
            node.position.z = zPosition
            SCNTransaction.commit()
        }
    }
  
    func animateTyping(withName name: String, zPosition: Float, duration: TimeInterval, in uiView: SCNView) {
          if let node = uiView.scene?.rootNode.childNode(withName: "GROUP_" + name.replacingOccurrences(of: "KEY_", with: ""), recursively: true) {
              SCNTransaction.begin()
              SCNTransaction.animationDuration = duration
              node.position.z = zPosition
              SCNTransaction.commit()
          }
    }
    
  func makeCoordinator() -> Coordinator {
          Coordinator(tappedNodeName: $tappedNodeName, isType: $isType)
          }

          class Coordinator: NSObject {
              @Binding var tappedNodeName: String?
              @Binding var isType: Bool
  //            @Binding var isCLicking: Bool

              init(tappedNodeName: Binding<String?>, isType: Binding<Bool>) {
                  _tappedNodeName = tappedNodeName
                  _isType = isType
              }

              @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
                  // Get the scene view from the gesture recognizer
                  guard let sceneView = gestureRecognizer.view as? SCNView else { return }

                  // Get the tap location in the scene view
                  let location = gestureRecognizer.location(in: sceneView)

                  // Perform a hit test to find intersected nodes
                  let hitResults = sceneView.hitTest(location, options: nil)

                  // Check if there are any intersected nodes
                  if let firstHitResult = hitResults.first {
                      // Access the node that was tapped
                      let tappedNode = firstHitResult.node

                      // Get the name of the tapped node
                      let tappedNodeBeforeFilter = tappedNode.name ?? "Unnamed Node"
  //                    isClicking = true
                      
                      tappedNodeName = tappedNodeBeforeFilter.contains("KEY_") ? tappedNodeBeforeFilter : "none"
                      isType = true
//                      print(isType)
                      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                          self.isType = false
//                          print(self.tappedNodeName)
//                          print(self.isType)
                      }
                      
                  }
              }
          }

}
