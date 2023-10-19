//
//  ContentView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 17/10/23.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @EnvironmentObject private var pathStore: PathStore
    
    var body: some View {
        ZStack{
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                Button("Example view") {
                    pathStore.navigateToView(.exampleWithParam("data"))
                }
            }
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
