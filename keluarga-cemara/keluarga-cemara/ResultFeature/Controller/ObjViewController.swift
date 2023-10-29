//
//  ObjViewController.swift
//  SceneUiKit
//
//  Created by M Yogi Satriawan on 27/10/23.
//
import SwiftUI
import SceneKit
//
//struct SceneKitView: UIViewRepresentable {
//    let scene: PhysicallyBasedScene
//
//    func makeUIView(context: Context) -> SCNView {
//        let sceneView = SCNView()
//        sceneView.scene = scene
//        sceneView.autoenablesDefaultLighting = true
//        sceneView.allowsCameraControl = true
//        return sceneView
//    }
//
//    func updateUIView(_ uiView: SCNView, context: Context) {
//
//    }
//}
//


struct SceneKitView: UIViewRepresentable {
    @ObservedObject var lightPosition: LightPosition
    var scene: PhysicallyBasedScene
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.isPlaying = true
        sceneView.loops = true
        sceneView.antialiasingMode = .multisampling4X
        return sceneView
    }

   //create updateUIView to update change of light orientation
    func updateUIView(_ uiView: SCNView, context: Context) {
        let orientation = getXYZOrientation()
        uiView.scene?.rootNode.childNode(withName: "Light", recursively: true)?.eulerAngles = SCNVector3(orientation.x,orientation.y,orientation.z)
    }

   func getXYZOrientation() -> (x: Float, y: Float, z: Float){
        let x = lightPosition.orientation_x
        let y = lightPosition.orientation_y
        let z = Float(0)
        return (x,y,z)
    }

    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: SceneKitView
        
        init(_ parent: SceneKitView) {
            self.parent = parent
        }
        
        @objc func handleSliderChange() {
        }
        
    }
    
    
}
struct SliderEditLight: View {
    @ObservedObject var lightPosition = LightPosition()
    let sunManager = LocationManager()
    @State var selectedTime: TimeInterval = 0.0
    
    var body: some View {
        ZStack {
            SceneKitView(lightPosition: lightPosition, scene: PhysicallyBasedScene(lightPosition: lightPosition))
            Text("\(sunManager.sun?.azimuth.radians ?? 0.0)")
            VStack {
                Spacer()
                Spacer()
                Slider(value: Binding(
                    get: {
                        if let azimuthInRadians = sunManager.sun?.azimuth.radians,
                           let elevationInRadians = sunManager.sun?.altitude.radians {
                            // Convert azimuth and elevation from radians to degrees
                            let azimuth = azimuthInRadians * 180 / .pi
                            let elevation = elevationInRadians * 180 / .pi
                            
                            // Return the combined value (azimuth + elevation)
                            return Double(azimuth + elevation)
                        }
                        return 0.0
                    },
                    set: { newValue in
                        //convert timeinterval to date
                        let currentTime = Date(timeIntervalSinceNow: newValue)
                        
                        //setup sun to the date
                        sunManager.sun?.setDate(currentTime)
                        
                        // Separate the value into azimuth and elevation components
                        let azimuth = newValue/2 // Half of the value (you can adjust this as needed)
                        let elevation = newValue/2 // Half of the value (you can adjust this as needed)
                        
                        // Update the orientation_x and orientation_y with new values
                        lightPosition.orientation_x = convertRadToDeg(from: azimuth )
                        lightPosition.orientation_y = convertRadToDeg(from: elevation )
                    }
                ), in: -180...45, step: 1.0)
                Spacer()
            }
        }
    }
    
    var sunRiseTime : TimeInterval {
        return sunManager.sun?.sunrise.timeIntervalSinceNow ?? 0.0
    }
    
    var sunSetTime : TimeInterval {
        return sunManager.sun?.sunset.timeIntervalSinceNow ?? 0.0
    }
    
    func convertRadToDeg(from rad: Double) -> Float {
        return Float(rad * 180 / .pi)
    }
}
