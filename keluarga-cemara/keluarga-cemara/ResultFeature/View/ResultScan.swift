//
//  ResultScan.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 20/11/23.
//

import SwiftUI
import SceneKit

struct ResultScan: View {
    @EnvironmentObject private var pathStore: PathStore
    @State private var isLoading : Bool = true
    @StateObject var lightPosition = LightPosition()
    @State var selectedPlantModel : TypeOfPlant? = nil
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
            }
            
            VStack{
                HStack{
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "ruler")
                            .font(.system(size: 40))
                            .foregroundStyle(Color(.black).opacity(0.5))
                    })
                    .padding()
                    .frame(width: 72, height: 48)
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
    ResultScan()
}
