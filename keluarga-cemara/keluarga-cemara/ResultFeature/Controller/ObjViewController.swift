//
//  ObjViewController.swift
//  SceneUiKit
//
//  Created by M Yogi Satriawan on 27/10/23.


import SwiftUI
import SceneKit

struct SceneKitViewAll: UIViewRepresentable {
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
        let orientations = getXYZOrientation()
        let firstOrientation = orientations[0]
        
        
        
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            uiView.scene?.rootNode.childNode(withName: "Light", recursively: false)?.eulerAngles = SCNVector3(firstOrientation.x, firstOrientation.y, firstOrientation.z)
            
        }
        
        uiView.antialiasingMode = .multisampling4X
        uiView.autoenablesDefaultLighting = true
        uiView.allowsCameraControl = true
        
        
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
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: SceneKitViewAll
        
        init(_ parent: SceneKitViewAll) {
            self.parent = parent
        }
    }
    
}




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
        let orientations = getXYZOrientation()
        let firstOrientation = orientations[0]
        let secondOrientation = orientations[1]
        
        
        
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            uiView.scene?.rootNode.childNode(withName: "Light", recursively: false)?.eulerAngles = SCNVector3(firstOrientation.x, firstOrientation.y, firstOrientation.z)
            
        }
        
        uiView.antialiasingMode = .multisampling4X
        uiView.autoenablesDefaultLighting = true
        uiView.allowsCameraControl = true
        
        
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

struct Coordinate: Hashable {
    var x: Double
    var y: Double
    var z: Double
}





struct ResultScanYogi: View {
    @EnvironmentObject private var pathStore: PathStore
    @State private var isLoading : Bool = true
    @State private var selectedTime : TimeInterval = 0.0
    @StateObject private var sunManager = LocationManager()
    @StateObject private var locationManager = LocationManager()
    @StateObject var lightPosition = LightPosition()
    @State private var sliderValue: Double = 0.0
    @State private var timer: Timer? = nil
    
    
    @State private var timeValue: [Double] = [06.00, 08.00, 10.00, 12.00, 13.00, 15.00, 17.00]
    @State private var coordinates: [Coordinate] = []
    
    let date = Date()
    var calendar = Calendar.current
    
    var selectedDate: Date? {
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = Int(sliderValue) // format 24 hours
        return calendar.date(from: dateComponents)
    }
    
    var body: some View {
        ZStack{
            Color(.graybg).ignoresSafeArea()
            
            VStack{
                Text("\(sunManager.resultOrientationDirection ?? "Partial Sun")")
                                 .calloutWhite()
                                 .multilineTextAlignment(.center)
                                 .frame(width: 239, height: 67)
                                 .padding()
                                 .background(Color(.black).opacity(0.7))
                                 .cornerRadius(14)
                
                if isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.brown))
                        .scaleEffect(4)
                        .frame(height: 400)
                } else {
                    SceneKitView(lightPosition: lightPosition, scene: PhysicallyBasedScene(lightPosition: lightPosition))
                        .frame(height: 400)
                }
                //        if sliderValue == 16.00{
                //            SceneKitViewAll(lightPosition: lightPosition, scene: PhysicallyBasedScene(lightPosition: lightPosition))
                //
                //        }
                
                HStack{
                    Spacer()
                    Button {
    //                    MARK: ka yogiee , taruh function yang kalau button ini di clik balek ke posisi awal
                    } label: {
                        Image(systemName: "goforward")
                            .font(.system(size: 32))
                            .padding(.all,5)
                            .foregroundStyle(Color.white)
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(40)
                    }
                    .padding(.trailing, 23)
                }

                //                MARK: Change slidernya yaa ka yogiix,

                if let selectedDate = selectedDate {
                    let selectedDatePlus30Minutes = calendar.date(byAdding: .minute, value: 0, to: selectedDate)
                    Slider(value: $sliderValue, in: 7.00...16.00, step: 1)
                        .padding()
                        .onChange(of: sliderValue) { newValue in
                            let sunPosition = locationManager.sun?.getSunHorizonCoordinatesFrom(date: selectedDatePlus30Minutes ?? Date())
                            let sunAltitude = sunPosition?.altitude
                            let sunAzimuth = sunPosition?.azimuth
                            
                            let r: Double = 1.0
                            let theta: Double = sunAltitude?.radians ?? 0.0
                            let phi: Double = sunAzimuth?.radians ?? 0.0
                            
                            let x = r * sin(theta) * cos(phi)
                            let y = r * sin(theta) * sin(phi)
                            let z = r * cos(theta)
                            
                            lightPosition.orientation_x[0] = Float(x)
                            lightPosition.orientation_y[0] = Float(y)
                            lightPosition.orientation_z[0] = Float(z)
                            
                        }
                }
                
                GeneralCostumButton(title: "See shade result", action: {
                    pathStore.navigateToView(.arview)
                }, isShowIcon: true)
            }
            
        }
        .toolbarBackground(.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2, execute: {
                isLoading = false
            })
        }
    }
    
}


















//            SceneKitView(lightPosition: lightPosition, scene: PhysicallyBasedScene(lightPosition: lightPosition))



//            Slider(value: $sliderValue, in: 7.00...16.00, step: 1)
//                .padding()
//                .onChange(of: sliderValue) { newValue in
//                    let sunPosition = locationManager.sun?.getSunHorizonCoordinatesFrom(date: selectedDatePlus30Minutes ?? Date())
//                    let sunAltitude = sunPosition?.altitude
//                    let sunAzimuth = sunPosition?.azimuth
//
//                    let r: Double = 1.0
//                    let theta: Double = sunAltitude?.radians ?? 0.0
//                    let phi: Double = sunAzimuth?.radians ?? 0.0
//
//                    let x = r * sin(theta) * cos(phi)
//                    let y = r * sin(theta) * sin(phi)
//                    let z = r * cos(theta)
//
//                    print("x: \(x), y: \(y), z: \(z)")
//
//                    lightPosition.orientation_x[0] = Float(x)
//                    lightPosition.orientation_y[0] = Float(y)
//                    lightPosition.orientation_z[0] = Float(z)
//
//                }
















//struct ResultScanYogi: View {
//    @EnvironmentObject private var pathStore: PathStore
//    @State private var isLoading : Bool = true
//    @State private var selectedTime  : TimeInterval  = 0.0
//    @StateObject private var sunManager = LocationManager()
//    @StateObject private var locationManager = LocationManager()
//    @ObservedObject var lightPosition = LightPosition()
//    @State private var sliderValue: Double = 0.0
//
//    var body: some View {
//        SceneKitView(lightPosition: lightPosition, scene: PhysicallyBasedScene(lightPosition: lightPosition))
//        Text("\(locationManager.sun?.altitude.radians ?? 0.0)")
//        Text("\(locationManager.sun?.azimuth.radians ?? 0.00)")
//
//        VStack{
//            Slider(value: $sliderValue, in: -50...(-44), step: 0.0000001)
//                      .onChange(of: sliderValue) { newValue in
//                          lightPosition.orientation_x = Float(newValue)
//                          print(newValue)
//                      }
//        }
//
//    }
//}


