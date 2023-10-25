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
    @State private var lightValue  : Float = 0
    
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
                    CustomSceneViewRepresentable(isLoading: $isLoading, lightValue: lightValue)
//                        .frame( height: UIScreen.main.bounds.height / 2 )
                }
                
                VStack{
                    Slider(value: $lightValue, in: 0...(2 * Float.pi))
                    Text("\(lightValue, specifier: "%.1f") Point")
                }
                .padding(.horizontal, 20)
                .frame(width: 400)
                
                GeneralCostumButton(title: "Start mapping the sun light", action: {
                    pathStore.navigateToView(.plantrecomend)
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



