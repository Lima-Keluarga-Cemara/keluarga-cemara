//
//  ARContainerView.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 11/11/23.
//

import SwiftUI

struct ARContainerView: View {
    @State private var showOrientation : Bool = false
    @State private var showShadePattern : Bool = false 
    @State private var sliderValue: Double = 0
    @StateObject private var sunManager  = LocationManager()
    @EnvironmentObject private var pathStore: PathStore

    
    var body: some View {
        ZStack{
            ARViewContainerRepresentable()
            VStack{
                HStack{
                    Spacer()
                    if showOrientation{
                        Text("\(sunManager.resultOrientationDirection ?? "Partial Sun")")
                            .calloutWhite()
                            .multilineTextAlignment(.center)
                            .frame(width: 239, height: 67)
                            .padding()
                            .background(Color(.grayTextResultOrientation))
                            .cornerRadius(14)

                    }
                    Spacer()
                    
                    Menu {
                        ButtonMenu(action: $showOrientation, title: "Garden Orientation")
                        ButtonMenu(action: $showShadePattern, title: "Shade Pattern")
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .colorMultiply(Color(.black))
                            .font(.system(size: 32))
                        
                    }
                    .padding(.trailing,20)
//                    try add frame , check clickable
                    .frame(width: 50, height: 50)

                }
                .padding(.top)

                
                

                Spacer()
                if showShadePattern{
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            Text("10 AM")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .bold()
                            Spacer()
                        }
                                        
                        Slider(value: $sliderValue, in: 0...10)
                        .tint(.yellow)
                        
                    }
                    .foregroundColor(.white)
                    .frame(height: 53)
                    .padding()
                    .background(Color(.colorGraySlider))
                    .cornerRadius(16)
                    .padding(.horizontal,30)
                    .padding(.bottom,20 )
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    pathStore.popToRoot()
                }
            }
        }
        .toolbarBackground(.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    ARContainerView()
}

