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
//    try add this for rotation
    
    
    
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
        
//        guard let urlPath = Bundle.main.url(forResource: "scan", withExtension: "usdz") else {
//            return
//        }
         let result = ResultFilePath()
        
        let scene = try? SCNScene(url: URL(string: "\(result.fileName())")!, options: [.checkConsistency : true])
//                let node  = SCNNode(geometry: scene?.rootNode.geometry)
        guard  let node = scene?.rootNode.childNode(withName: "room", recursively: true) else { return print("print data nill ")}
        
        //SETUP LIGHT
        let light = SCNLight()
        light.type = .directional
        light.color = UIColor(.red)
        light.castsShadow = true
        light.shadowMode = .modulated
        light.intensity = 4000
        node.light = light
         
        node.position = focusNode.position
        print("screen ar with object \(result.fileName())")
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
}

