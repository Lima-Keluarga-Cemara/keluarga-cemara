//
//  ARViewContainerRepresentable.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 11/11/23.
//

import SwiftUI
import SceneKit
import ARKit
import FocusNode
import SmartHitTest

extension ARSCNView: ARSmartHitTest {}

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
    
    var sceneView = ARSCNView(frame: .zero)
    let focusNode = FocusSquare()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Set the view's delegate
        sceneView.delegate = self
        // Setup Focus Node
        self.focusNode.viewDelegate = sceneView
        sceneView.scene.rootNode.addChildNode(self.focusNode)
        // Setup Coaching Overlay
        sceneView.addCoaching()
        sceneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))

        self.view = sceneView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // AR Config
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            configuration.sceneReconstruction = .meshWithClassification
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    func placeModel(){
        guard self.focusNode.onPlane else {
            print("Debut[FocusNode] on plane error")
            return
        }
        
        guard let urlPath = Bundle.main.url(forResource: "scan", withExtension: "usdz") else {
            return
        }
        
        guard let modelScene: SCNScene = try? SCNScene(url: urlPath, options: [.checkConsistency: true]), let node = modelScene.rootNode.childNode(withName: "scan", recursively: true) else { fatalError("unable to load model")}
        
        node.position = focusNode.position
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    // MARK: - ARSCNViewDelegate
    @objc func tapped(recognizer: UITapGestureRecognizer){
        let tappedLocation = recognizer.location(in: self.sceneView)
        let hitResult = sceneView.session.raycast(sceneView.raycastQuery(from: tappedLocation, allowing: .estimatedPlane, alignment: .horizontal)!)
        if !hitResult.isEmpty{
            self.addRoom(result: hitResult.first!)
        }
    }
    
    func addRoom(result: ARRaycastResult){
        print("ke tapppp ")

        guard let roomScene = SCNScene(named: "scan.scn"),
              let roomNode = roomScene.rootNode.childNode(withName: "scan", recursively: false)
        else {return print("Item nill") }

        roomNode.position = SCNVector3(x: result.worldTransform.columns.3.x, y: result.worldTransform.columns.3.y, z: result.worldTransform.columns.3.z)
//        roomNode.scale = SCNVector3(x: 0.005, y: 0.005, z: 0.005)
        sceneView.scene.rootNode.addChildNode(roomNode)
    }
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

