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
    var sceneView = SCNView(frame: .zero)
    
    func makeUIView(context: Context) -> SCNView {
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        
        //        if let recognizers = sceneView.gestureRecognizers {
        //            for recognizer in recognizers {
        //                recognizer.isEnabled = false
        //            }
        //        }
        
        /// Setup Tap Recognizer
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
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
        Coordinator(sceneView)
    }
    
    class Coordinator: NSObject {
        var parent: SCNView
        //        var nodesAdded = [SCNNode]()
        //        var distanceNodes = [SCNNode]()
        //        var lineNodes = [SCNNode]()
        
        init(_ parent: SCNView) {
            self.parent = parent
        }
        
        @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
            let currentTapLocation = gestureRecognize.location(in: self.parent)
            guard let hitTest = self.parent.hitTest(currentTapLocation, options: nil).first else { return }
            
            // Check if the hit test result has a SCNNode associated with it
            let parentNode = hitTest.node
            
            if parentNode.childNodes.count >= 2 {
                // If there are 2 or more child nodes, remove all existing nodes
                parentNode.childNodes.forEach { $0.removeFromParentNode() }
                print("Removed all existing nodes")
            }
            // Create a sphere geometry
            let sphereGeometry = SCNSphere(radius: 0.05) // You can adjust the radius as needed
            
            // Create a material for the sphere (you can customize the appearance)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.blue // Set the color of the sphere
            
            // Apply the material to the sphere
            sphereGeometry.materials = [material]
            
            // Create a new SCNNode with the sphere geometry
            let sphereNode = SCNNode(geometry: sphereGeometry)
            
            // Set the position of the sphere node based on the hit test result
            sphereNode.position = hitTest.localCoordinates
            
            // Add the sphere node to the parent node or the scene as needed
            parentNode.addChildNode(sphereNode)
            
            // Create a line geometry between two child nodes
            if parentNode.childNodes.count >= 2 {
                let firstNode = parentNode.childNodes[0]
                let secondNode = parentNode.childNodes[1]
                
                // Calculate the midpoint between the two nodes
                let midpoint = SCNVector3Make(
                    (firstNode.position.x + secondNode.position.x) / 2,
                    (firstNode.position.y + secondNode.position.y) / 2,
                    (firstNode.position.z + secondNode.position.z) / 2
                )
                
                // Create a line geometry with the positions of the two nodes
                let lineGeometry = SCNGeometry.lineFrom(vector: firstNode.position, toVector: secondNode.position)
                
                // Create a material for the line (you can customize the appearance)
                let lineMaterial = SCNMaterial()
                lineMaterial.diffuse.contents = UIColor.red // Set the color of the line
                
                // Apply the material to the line
                lineGeometry.materials = [lineMaterial]
                
                // Create a new SCNNode with the line geometry
                let lineNode = SCNNode(geometry: lineGeometry)
                
                // Add the line node to the parent node or the scene as needed
                parentNode.addChildNode(lineNode)
                
                // Calculate the distance between the two nodes
                let distance = distanceBetween(node1: firstNode, node2: secondNode)
                
                // Format the distance with commas
                let formattedDistance = formatDistanceWithCommas(distance: distance)
                
                // Display the distance as text at the midpoint
                let textNode = createTextNode(text: "\(formattedDistance) meters")
                textNode.position = midpoint
                parentNode.addChildNode(textNode)
                
                // Apply billboard constraint to the text node
                let billboardConstraint = SCNBillboardConstraint()
                textNode.constraints = [billboardConstraint]
                
                print("Distance between nodes: \(distance) meters")
            }
        }
        
        func distanceBetween(node1: SCNNode, node2: SCNNode) -> Float {
            let distanceVector = SCNVector3Make(
                node2.position.x - node1.position.x,
                node2.position.y - node1.position.y,
                node2.position.z - node1.position.z
            )
            return sqrtf(distanceVector.x * distanceVector.x + distanceVector.y * distanceVector.y + distanceVector.z * distanceVector.z)
        }
        
        func createTextNode(text: String) -> SCNNode {
            let textGeometry = SCNText(string: text, extrusionDepth: 0.1)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.white
            
            let textNode = SCNNode(geometry: textGeometry)
            textNode.scale = SCNVector3(0.01, 0.01, 0.01) // Adjust the scale as needed
            
            return textNode
        }
        
        func formatDistanceWithCommas(distance: Float) -> String {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 2 // Set the desired number of decimal places
            
            return numberFormatter.string(from: NSNumber(value: distance)) ?? "\(distance)"
        }
    }
    
}

extension SCNGeometry {
    class func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNGeometry {
        //        let indices: [UInt32] = [0, 1]
        //
        //        let source = SCNGeometrySource(vertices: [vector1, vector2])
        //        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        let vertices: [SCNVector3] = [vector1, vector2]
        let data = NSData(bytes: vertices, length: MemoryLayout<SCNVector3>.size * vertices.count) as Data
        
        let vertexSource = SCNGeometrySource(data: data,
                                             semantic: .vertex,
                                             vectorCount: vertices.count,
                                             usesFloatComponents: true,
                                             componentsPerVector: 3,
                                             bytesPerComponent: MemoryLayout<Float>.size,
                                             dataOffset: 0,
                                             dataStride: MemoryLayout<SCNVector3>.stride)
        
        
        let indices: [Int32] = [ 0, 1]
        
        let indexData = NSData(bytes: indices, length: MemoryLayout<Int32>.size * indices.count) as Data
        
        let element = SCNGeometryElement(data: indexData,
                                         primitiveType: .line,
                                         primitiveCount: indices.count/2,
                                         bytesPerIndex: MemoryLayout<Int32>.size)
        
        return SCNGeometry(sources: [vertexSource], elements: [element])
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
    @Environment(\.presentationMode) var presentationMode
    
    
    
    
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
                
                //                ButtonCustom(title: "See measure", action: {
                //                    isShowingFloorPlan = true
                //                }, width: 300, height: 48)
                //
                //                .padding(.bottom)
                if isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.brown))
                        .scaleEffect(4)
                        .frame(height: 500)
                    
                } else {
                    SceneKitView(lightPosition: lightPosition, scene: PhysicallyBasedScene(lightPosition: lightPosition))
                        .frame(height: 500)
                }
                Spacer()
                
            }
            
            
            ModalSheetColor()
                .offset(y:offsetPositionY)
                .offset(y: currentPositionY)
                .gesture(
                    DragGesture()
                        .onChanged{ item in
                            withAnimation(.spring()){
                                currentPositionY = item.translation.height
                            }
                        }
                        .onEnded{ item in
                            withAnimation(.spring()){
                                
                                currentPositionY = -135
                            }
                        }
                )
            
            
        }
        
        .navigationBarBackButtonHidden()
        .onAppear {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2, execute: {
                isLoading = false
            })
        }
        .fullScreenCover(isPresented: $isShowingFloorPlan) {
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 28))
                    })
                }
                
                SceneView(scene: FloorPlanScene(capturedRoom: RoomController.instance.finalResults!), options: [.allowsCameraControl])
            }
        }
        
    }
    
    
}


struct ModalSheetColor : View {
    @State private var isRecommendationPlantPartialSunSheetPresented: Bool = false
    @State private var isRecommendationPlantPartialShadeSheetPresented: Bool = false
    @State private var isRecommendationPlantFullSunSheetPresented: Bool = false
    @State private var isRecommendationPlantFullShadeSheetPresented: Bool = false
    
    
    
    @EnvironmentObject private var pathStore: PathStore
    
    var body: some View {
        
        VStack(alignment : .leading){
            HStack{
                Spacer()
                Image(systemName: "chevron.up")
                    .font(.system(size: 24))
                    .padding()
                Spacer()
                
            }
            
            Text("Shadow indicator")
                .titleInstruction()
                .padding(.bottom,12)
            
            HStack{
                ButtonShadow(action: {
                    
                }, title: "0-2 hours", typePlant: .fullshade, firstColor: .firtsShadow, secondColor: .secondShadow)
                
                ButtonShadow(action: {
                    isRecommendationPlantPartialSunSheetPresented.toggle()
                }, title: "0-2 hours", typePlant: .partialsun, firstColor: .firtsShadow, secondColor: .secondShadow)
                .sheet(isPresented: $isRecommendationPlantPartialSunSheetPresented) {
                    RecommendListCardView(
                        title: "Partian Sun",
                        data: RecommendPlantMock.separatePlantsByType(.partialsun),
                        columnGrid: [GridItem(.flexible()), GridItem(.flexible())]
                    )
                    
                }
                
                ButtonShadow(action: {
                    isRecommendationPlantPartialShadeSheetPresented = true
                }, title: "2-4 hours", typePlant: .fullshade, firstColor: .secondShadow, secondColor: .thirdShadow)
                .sheet(isPresented: $isRecommendationPlantPartialShadeSheetPresented){
                    RecommendListCardView(
                        title: "Partial Sun",
                        data: RecommendPlantMock.separatePlantsByType(.partialshade),
                        columnGrid: [GridItem(.flexible()), GridItem(.flexible())]
                    )
                    
                }
                
                
                
                ButtonShadow(action: {
                    isRecommendationPlantFullSunSheetPresented = true
                }, title: "4-6 hours", typePlant: .fullshade, firstColor: .thirdShadow, secondColor: .fourthShadow)
                .sheet(isPresented: $isRecommendationPlantFullSunSheetPresented) {
                    RecommendListCardView(
                        title: "Full Sun Boy",
                        data: RecommendPlantMock.separatePlantsByType(.fullsun),
                        columnGrid: [GridItem(.flexible()), GridItem(.flexible())]
                    )
                }
                
                ButtonShadow(action: {
                    isRecommendationPlantFullShadeSheetPresented = true
                }, title: "6+ hours", typePlant: .fullshade, firstColor: .fourthShadow, secondColor: .seventhShadow)
                .sheet(isPresented: $isRecommendationPlantFullShadeSheetPresented) {
                    RecommendListCardView(
                        title: "Full Sun",
                        data: RecommendPlantMock.separatePlantsByType(.fullshade),
                        columnGrid: [GridItem(.flexible()), GridItem(.flexible())]
                    )
                    
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            
        }
        .padding(.horizontal,16)
        .padding(.bottom)
        .background(Color.white)
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

struct testviewrecomend:View {
    var body: some View {
        RecommendListCardView(
            title: "Full shade",
            data: RecommendPlantMock.separatePlantsByType(.partialsun),
            columnGrid: [GridItem(.flexible()), GridItem(.flexible())]
        )
    }
}

#Preview{
    testviewrecomend()
}



#Preview{
    ResultScanYogi()
}





