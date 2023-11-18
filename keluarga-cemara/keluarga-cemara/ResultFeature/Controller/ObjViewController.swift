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
        let x = lightPosition.orientation_x[0]
        let y = lightPosition.orientation_y[0]
        let z = lightPosition.orientation_z[0]
        let orientation = SCNVector3(x, y, z)
        orientations.append(orientation)
        print(orientation)
        
        
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
    @State var isSheetOpen : Bool = true
    
    var body: some View {
        ZStack{
            Color(.graybg).ignoresSafeArea()
            
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
                
               
                
                if isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.brown))
                        .scaleEffect(4)
                        .frame(height: 700)

                } else {
                    SceneKitView(lightPosition: lightPosition, scene: PhysicallyBasedScene(lightPosition: lightPosition))
                        .frame(height: 700)
                }
            }
        }
        .sheet(isPresented: $isSheetOpen, content: {
            ModalSheetColor()
                .presentationDetents([.height(80), .height(240)])
        })

        .navigationBarBackButtonHidden()
        .onAppear {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2, execute: {
                isLoading = false
            })
        }
        
    }
    
    
}


struct ModalSheetColor : View {
    var body: some View {
        VStack(alignment : .leading){
            Text("Shadow indicator")
                .titleInstruction()
                .padding(.bottom,18)
            
            HStack{
                ButtonShadow(action: {
                    
                }, title: "0-2 hours", typePlant: .fullshade, firstColor: .firtsShadow, secondColor: .secondShadow)
                
                ButtonShadow(action: {
                    
                }, title: "2-4 hours", typePlant: .fullshade, firstColor: .secondShadow, secondColor: .thirdShadow)
                
                ButtonShadow(action: {
                    
                }, title: "4-6 hours", typePlant: .fullshade, firstColor: .thirdShadow, secondColor: .fourthShadow)
                
                ButtonShadow(action: {
                    
                }, title: "6+ hours", typePlant: .fullshade, firstColor: .fourthShadow, secondColor: .seventhShadow)
            }
            
        }
        .padding(.horizontal,16)
    }
}

struct ButtonShadow : View {
    let action : () -> Void
    let title : String
    let typePlant : TypeOfPlant
    let firstColor : ColorResource
    let secondColor  : ColorResource
   
    
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .font(.system(size: 12, weight: .regular, design: .rounded))
                .foregroundStyle(Color(.white))
                .frame(width: 77, height: 77)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(firstColor), Color(secondColor)]), startPoint: .leading, endPoint: .trailing)
                    
                )
                .cornerRadius(9)
                .overlay(
                       RoundedRectangle(cornerRadius: 9)
                           .stroke(Color.white, lineWidth: 1)
                   )
        })
    }
}



#Preview{
   ResultScanYogi()
}





