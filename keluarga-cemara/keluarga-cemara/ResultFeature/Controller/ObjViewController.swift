//
//  ObjViewController.swift
//  SceneUiKit
//
//  Created by M Yogi Satriawan on 27/10/23.


import SwiftUI
import SceneKit
import _SceneKit_SwiftUI

//struct SceneKitViewAll: UIViewRepresentable {
//    @ObservedObject var lightPosition: LightPosition
//    var scene: PhysicallyBasedScene
//    
//    func makeUIView(context: Context) -> SCNView {
//        let sceneView = SCNView(frame: .zero)
//        sceneView.scene = scene
//        sceneView.autoenablesDefaultLighting = true
//        sceneView.allowsCameraControl = true
//        return sceneView
//    }
//    
//    
//    func updateUIView(_ uiView: SCNView, context: Context) {
//        let orientations = getXYZOrientation()
//        let firstOrientation = orientations[0]
//        
//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
//            uiView.scene?.rootNode.childNode(withName: "Light", recursively: false)?.eulerAngles = SCNVector3(firstOrientation.x, firstOrientation.y, firstOrientation.z)
//            
//        }
//        
//        uiView.antialiasingMode = .multisampling4X
//        uiView.autoenablesDefaultLighting = true
//        uiView.allowsCameraControl = true
//        
//        
//    }
//    
//    
//    
//    func getXYZOrientation() -> [SCNVector3] {
//        var orientations: [SCNVector3] = []
//        let x = lightPosition.orientation_x[0]
//        let y = lightPosition.orientation_y[0]
//        let z = lightPosition.orientation_z[0]
//        let orientation = SCNVector3(x, y, z)
//        orientations.append(orientation)
//        print(orientation)
//        
//        
//        return orientations
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject {
//        var parent: SceneKitViewAll
//        
//        init(_ parent: SceneKitViewAll) {
//            self.parent = parent
//        }
//    }
//    
//}




struct SceneKitView: UIViewRepresentable {
    @ObservedObject var lightPosition: LightPosition
    var scene: PhysicallyBasedScene
    
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView(frame: .zero)
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
    
        
        //        if let recognizers = sceneView.gestureRecognizers {
        //            for recognizer in recognizers {
        //                recognizer.isEnabled = false
        //            }
        //        }
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
        //        if let recognizers = uiView.gestureRecognizers {
        //            for recognizer in recognizers {
        //                recognizer.isEnabled = false
        //            }
        //        }
        
        
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
    @StateObject var lightPosition = LightPosition()
    @State var selectedPlantModel : TypeOfPlant? = nil
    @State var offsetPositionY : CGFloat = UIScreen.main.bounds.height * 0.5
    @State var currentPositionY : CGFloat = 0
    @State private var isShowingFloorPlan = false
    @State private var isShowingSheet = true
    @Environment(\.presentationMode) var presentationMode



    
    var body: some View {
        ZStack{
            Color(.graybg).ignoresSafeArea()
            
            if isLoading{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.brown))
                    .scaleEffect(4)
                    .frame(height: 500)

            } else {
                SceneKitView(lightPosition: lightPosition, scene: PhysicallyBasedScene(lightPosition: lightPosition))
                    .ignoresSafeArea()
//                        .frame(height: 500)
            }
            
            VStack{
                HStack{
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "arrow.uturn.left")
                            .font(.system(size: 25))
                            .foregroundStyle(Color(.black).opacity(0.5))
                    })
                    .padding()
                    .frame(width: 52, height: 48)
                    .background(Color(.whiteButton))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    
                    Spacer()
                    
                    
                    ButtonCustom(title: "Done", action: {
                      
                    }, width: 80, height: 48)
                    
                }
                .padding(16)
                .padding(.bottom)
             
                Spacer()

            }
               
        }
        .sheet(isPresented: $isShowingSheet, content: {
            ModalSheetColor()
                .presentationDetents([.height(120), .height(249)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(249)))
                .interactiveDismissDisabled()
        })
        .navigationBarBackButtonHidden()
        .onAppear {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2, execute: {
                isLoading = false
            })
        }
    }
    
    
}




#Preview{
   ResultScanYogi()
}





