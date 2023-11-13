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
    @ObservedObject var viewModel: ARViewModel
    
    func makeUIViewController(context: Context) ->  ViewController {
        let viewController = ViewController()
        viewModel.setViewController(viewController)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}

#Preview {
    ARViewContainerRepresentable(viewModel: ARViewModel())
}

class ViewController:UIViewController, ARSCNViewDelegate{
    var sceneView = ARSCNView(frame: .zero)
    let focusNode = FocusSquare()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Set the view's delegate
        sceneView.delegate = self
        // Setup Focus Node
        self.focusNode.viewDelegate = sceneView
        sceneView.scene.rootNode.addChildNode(self.focusNode)
        // Setup Gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        sceneView.addGestureRecognizer(panGesture)
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotate(_:)))
        sceneView.addGestureRecognizer(rotateGesture)
        
        
        // Setup Coaching Overlay
        sceneView.addCoaching()
        
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
        node.name = "scan"
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    @objc func didPan(_ gesture: UIPanGestureRecognizer) {
        guard let node = sceneView.scene.rootNode.childNode(withName:"scan", recursively: true) else { return }
        
        let location = gesture.location(in: self.sceneView)
        
        switch gesture.state {
        case .changed:
            guard let result = self.sceneView.hitTest(location, types: .existingPlane).first
            else { return }
            let transform = result.worldTransform
            let newPosition = SIMD3<Float>(transform.columns.3.x,transform.columns.3.y,transform.columns.3.z)
            node.simdPosition = newPosition
        default:
            break
        }
    }
    
    @objc func didRotate(_ gesture: UIRotationGestureRecognizer) {
        guard let node = sceneView.scene.rootNode.childNode(withName:"scan", recursively: true) else { return }
        
        node.eulerAngles.y -= Float(gesture.rotation)
        gesture.rotation = 0
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

