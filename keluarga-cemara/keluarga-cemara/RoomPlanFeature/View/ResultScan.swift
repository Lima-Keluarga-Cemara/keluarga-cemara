//
//  ResultScan.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import SwiftUI
 

struct ResultScan: View {
    @EnvironmentObject private var pathStore: PathStore
    @State private var isLoading : Bool = true
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color(.firstGradientOrange), Color(.secondGradientOrange), Color(.thirdGradientOrange)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            
            VStack(spacing : 50){
                if isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(.primaryGreen)))
                        .scaleEffect(4)
                        .frame( height: UIScreen.main.bounds.height / 2 )
                    
                } else {
                    CustomSceneViewRepresentable(isLoading: $isLoading)
                        .frame( height: UIScreen.main.bounds.height / 2 )
                }
                
                
                GeneralCostumButton(title: "Start mapping the sun light", action: {
                    print("Testing")
                } )
                
            }
        }
        .onAppear(perform: {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2.0, execute: {
                isLoading = false
            })
        })
    }
    
    
}

#Preview {
    ResultScan()
}



