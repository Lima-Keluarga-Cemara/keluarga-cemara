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


import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable {
    @ObservedObject var lightPosition: LightPosition
    var scene: PhysicallyBasedScene
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        let orientation = getXYZOrientation()
           
           UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
               uiView.scene?.rootNode.childNode(withName: "Light", recursively: false)?.eulerAngles = SCNVector3(orientation.x, orientation.y, orientation.z)
           }
           
           uiView.antialiasingMode = .multisampling4X
           uiView.autoenablesDefaultLighting = true
           uiView.allowsCameraControl = true
 

    }

    func getXYZOrientation() -> SCNVector3 {
        return SCNVector3(lightPosition.orientation_x, lightPosition.orientation_y, 0.0)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: SceneKitView
        
        init(_ parent: SceneKitView) {
            self.parent = parent
        }
    }
}



//struct SliderEditLight: View {
//    @ObservedObject var lightPosition = LightPosition()
//    @EnvironmentObject private var pathStore: PathStore
//    @StateObject private var roomController = RoomController.instance
//    @StateObject private var locationManager = LocationManager()
//    @State private var isStartScanning : Bool = false
//
//    @State private var sheetOpening : Bool = false
//    @State private var showingOption : Bool = false
//    @State private var feedbackGenerator: UIImpactFeedbackGenerator?
//    
//    
//    var body: some View {
//        VStack{
//            
//            
//            
//            ZStack{
//                Rectangle()
//                    .fill(Color.black)
//                    .frame(height: 150)
//                
//                
//                Button(action: {
//                    if isStartScanning{
//                        roomController.stopSession()
//                        isStartScanning = false
//                        pathStore.navigateToView(.roomscanresult)
//                        feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
//                        feedbackGenerator?.impactOccurred()
//                        locationManager.resultOrientationDirection = locationManager.orientationGarden
//                    } else {
//                        roomController.startSession()
//                        isStartScanning = true
//                        feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
//                        feedbackGenerator?.impactOccurred()
//                    }
//                }, label: {
//                    Image(systemName: isStartScanning ? "stop.circle" : "circle.inset.filled")
//                        .foregroundColor( isStartScanning ? .red : .white )
//                        .font(.system(size: 64))
//                })
//                
//            }
//        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//                ZStack {
//                    SceneKitView(lightPosition: lightPosition, scene: PhysicallyBasedScene(lightPosition: lightPosition))
//                    VStack {
//                        Spacer()
//                        Spacer()
//                        CustomSlider(value: Binding(
//                            get: {
//                                if let azimuthInRadians = locationManager.sun?.azimuth.radians,
//                                   let elevationInRadians = locationManager.sun?.altitude.radians {
//                                    // Convert azimuth and elevation from radians to degrees
//                                    let azimuth = azimuthInRadians * 180 / .pi
//                                    let elevation = elevationInRadians * 180 / .pi
//                                    
//                                    // Return the combined value (azimuth + elevation)
//                                    return Double(azimuth + elevation)
//                                }
//                                
//                                return 0 // Handle a default case when data is not available
//                            },
//                            set: { newValue in
//                                // Separate the value into azimuth and elevation components
//                                let azimuth = newValue / 2 // Half of the value (you can adjust this as needed)
//                                let elevation = newValue / 2 // Half of the value (you can adjust this as needed)
//
//                                // Update the orientation_x and orientation_y with new values
//                                lightPosition.orientation_x = Float(azimuth)
//                                lightPosition.orientation_y = Float(elevation)
//                            }
//                        ), rangeSlide: 1.0...100.0)
//                        Spacer()
//                    }
//                }
//    }
//}
//

struct ResultScanYogi: View {
    @EnvironmentObject private var pathStore: PathStore
    @State private var isLoading : Bool = true
    @State private var selectedTime  : TimeInterval  = 0.0
    @StateObject private var sunManager = LocationManager()
    @StateObject private var locationManager = LocationManager()
    @ObservedObject var lightPosition = LightPosition()


    var body: some View {
        SceneKitView(lightPosition: lightPosition, scene: PhysicallyBasedScene(lightPosition: lightPosition))
        Text("\(locationManager.sun?.altitude.radians ?? 0.0)")
        
        ZStack{
            Slider(value: Binding(
                get: {
                    if let azimuthInRadians = locationManager.sun?.azimuth.radians,
                       let elevationInRadians = locationManager.sun?.altitude.radians {
                        // Convert azimuth and elevation from radians to degrees
                        let azimuth = azimuthInRadians * 180 / .pi
                        _ = elevationInRadians * 180 / .pi

                        // Calculate X orientation with 0 at the rightmost position (east)
                        let orientation_x = (180 - azimuth) // Adjust for the orientation

                        // Return the X orientation
                        return Double(orientation_x)
                    }

                    return 0 // Handle a default case when data is not available
                },
                set: { newValue in
                    // Update the orientation_x with the new X orientation
                    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
                              // Update the orientation_x with the new X orientation
                              let azimuth = newValue / 12 // Adjust for the orientation
                              lightPosition.orientation_x = Float(azimuth)
                          }
                          animator.startAnimation()
                }
            ), in: -45...0, step: 0.0000000001)// Range from east (0) to west (360)
            .frame(width: 230, height: 10)

        }
     
    }
}

#Preview {
    ResultScanYogi()
}




