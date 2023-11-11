//
//  ARViewContainerRepresentable.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 11/11/23.
//

import SwiftUI
import SceneKit
import ARKit

struct ARViewContainerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) ->  ViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}

#Preview {
    ARViewContainerRepresentable()
}

class ViewController:UIViewController, ARSCNViewDelegate{
    
    var sceneView: ARSCNView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let sceneView = ARSCNView(frame: .zero)
        self.sceneView = sceneView
        // Set the view's delegate
        sceneView.delegate = self
        
        //        AR Config
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)

        self.view = sceneView
    }
    
    // MARK: - ARSCNViewDelegate

    //Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let planeAnchor = anchor as? ARPlaneAnchor {
            
            if planeAnchor.alignment == .horizontal {
                let plane = SCNPlane(width: CGFloat(planeAnchor.planeExtent.width), height: CGFloat(planeAnchor.planeExtent.height))
                let planeNode = SCNNode(geometry: plane)
                createHostingController(for: planeNode)
                node.addChildNode(planeNode)
            }
            print("On Trackingg...")
        }

        return node
    }
    
    func createHostingController(for node: SCNNode) {
        
        DispatchQueue.main.async {
            let arVC = UIHostingController(rootView: InformationShadeView())
            
            arVC.willMove(toParent: self)
            self.addChild(arVC)
            arVC.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            self.view.addSubview(arVC.view)
            self.show(hostingVC: arVC, on: node)
        }
    }
    
    func show(hostingVC: UIHostingController<InformationShadeView>, on node: SCNNode) {
        let material = SCNMaterial()
        hostingVC.view.isOpaque = false
        material.diffuse.contents = hostingVC.view
        node.geometry?.materials = [material]
        hostingVC.view.backgroundColor = UIColor.clear
    }
    
}

