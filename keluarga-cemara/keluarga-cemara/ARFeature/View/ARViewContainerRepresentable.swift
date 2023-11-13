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
    @ObservedObject var lightPosition: LightPosition
    var scene: PhysicallyBasedScene
    
    func makeUIViewController(context: Context) ->  ViewController {
        let viewController = ViewController(sceneViewBaseModel: scene, lightPosition: lightPosition)
        viewModel.setViewController(viewController)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        let orientations = getXYZOrientation()
        let firstOrientation = orientations[0]
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            uiViewController.sceneView.scene.rootNode.childNode(withName: "Light", recursively: false)?.eulerAngles = SCNVector3(firstOrientation.x, firstOrientation.y, firstOrientation.z)
            
        }
        
        uiViewController.sceneView.antialiasingMode = .multisampling4X
        uiViewController.sceneView.autoenablesDefaultLighting = true
        uiViewController.sceneView.allowsCameraControl = true
    }
    
    func getXYZOrientation() -> [SCNVector3] {
        var orientations: [SCNVector3] = []
        
        for i in 0..<6 {
            let x = lightPosition.orientation_x[i]
            let y = lightPosition.orientation_y[i]
            let z = lightPosition.orientation_z[i]
            let orientation = SCNVector3(x, y, z)
            orientations.append(orientation)
            print(orientation)
        }
        
        return orientations
    }
}

#Preview {
    ARViewContainerRepresentable(viewModel: ARViewModel(), lightPosition: LightPosition(), scene: PhysicallyBasedScene(lightPosition: LightPosition()))
}

class ViewController:UIViewController, ARSCNViewDelegate{
    var sceneViewBaseModel : PhysicallyBasedScene?
    var lightPosition: LightPosition?
    var sceneView = ARSCNView(frame: .zero)
    let focusNode = FocusSquare()
    var previousTranslation = SIMD3<Float>()
    
    init(sceneViewBaseModel: PhysicallyBasedScene, lightPosition: LightPosition) {
        super.init(nibName: nil, bundle: nil)
        self.sceneViewBaseModel = sceneViewBaseModel
        self.lightPosition = lightPosition
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sceneView.autoenablesDefaultLighting = true
        
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
        //                let result = ResultFilePath()
        
        //        let scene = try? SCNScene(url: URL(string: "\(result.fileName())")!, options: [.checkConsistency : true])
        //        let scene = try? SCNScene(url: urlPath, options: [.checkConsistency : true])
        //                let node  = SCNNode(geometry: scene?.rootNode.geometry)
        //        guard  let node = scene?.rootNode.childNode(withName: "room", recursively: true) else { return print("print data nill ")}
        //        guard  let node = scene?.rootNode.childNode(withName: "scan", recursively: true) else { return print("print data nill ")}
        // Setup scene 3d model from scenekit
        sceneViewBaseModel?.rootNode.position = focusNode.position
        sceneView.scene = sceneViewBaseModel!
        
    }
    
    @objc func didPan(_ gesture: UIPanGestureRecognizer) {
        guard let node = sceneView.scene.rootNode.childNode(withName:"room", recursively: false) else { return }
        
        let location = gesture.location(in: sceneView)
        var newPosition = SIMD3<Float>()
        
        switch gesture.state {
        case .changed:
            let raycastQuery: ARRaycastQuery? = sceneView.raycastQuery(from: location,allowing: .estimatedPlane, alignment: .horizontal)
            
            let results: [ARRaycastResult] = sceneView.session.raycast(raycastQuery!)
            
            guard let result = results.first else { return }
            let transform = result.worldTransform
            
            newPosition = SIMD3<Float>(transform.columns.3.x,transform.columns.3.y,transform.columns.3.z)
            node.simdPosition = newPosition
            break
        default:
            break
        }
    }
    
    @objc func didRotate(_ gesture: UIRotationGestureRecognizer) {
        guard let node = sceneView.scene.rootNode.childNode(withName:"room", recursively: false) else { return }
        
        node.eulerAngles.y -= Float(gesture.rotation)
        gesture.rotation = 0
    }
}

