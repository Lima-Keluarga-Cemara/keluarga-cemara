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
        // Setup Coaching Overlay
        sceneView.addCoaching()
        
//        try to rotate and scale
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        sceneView.addGestureRecognizer(rotateGesture)
        
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
        
        let light = SCNLight()
        light.type = .directional
        light.color = UIColor(.red)
        light.castsShadow = true
        light.shadowMode = .modulated
        light.intensity = 4000
       node.light = light
         
        node.position = self.focusNode.position
        print("screen ar with object \(result.fileName())")
        self.sceneView.scene.rootNode.addChildNode(node)

    }
    
    // MARK: - TRY rotate and scale
    
  
    @objc func handleRotation(_ gesture : UIRotationGestureRecognizer){
        guard let node = sceneView.scene.rootNode.childNode(withName: "scan", recursively: true) else {return}
        node.eulerAngles.y = Float(gesture.rotation)
        gesture.rotation = 0
    }
    
   
    
}

