//
//  CustomSceneViewRepresentable.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 20/10/23.
//

import SwiftUI
import SceneKit

struct CustomSceneViewRepresentable : UIViewRepresentable{
    @Binding var isLoading : Bool
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = true
        view.backgroundColor = .clear
        view.autoenablesDefaultLighting = true
        let fm = FileManager.default
        let path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "room.usdz"
        let modelFilePath  = path.appendingPathComponent(fileName).absoluteString
        DispatchQueue.main.async {
            do {
                let scene = try? SCNScene(url: URL(string: "\(modelFilePath)")!)
                view.scene = scene
            }
        }
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
