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
    @StateObject private var sunManager  = LocationManager()
    @EnvironmentObject private var pathStore: PathStore
    @StateObject var viewModel = ARViewModel()
    @StateObject var lightPosition = LightPosition()
    @State private var sliderValue: Double = 0.0
    @State private var isAlreadyPlace : Bool = false
    @State private var isAlreadyLock : Bool = false
    
    let date = Date()
    var calendar = Calendar.current
    var selectedDate: Date? {
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = Int(sliderValue) // format 24 hours
        return calendar.date(from: dateComponents)
    }
    
    var body: some View {
        ZStack{
            ARViewContainerRepresentable(
                viewModel: viewModel,
                lightPosition: lightPosition,
                scene: PhysicallyBasedScene(lightPosition: lightPosition)
            )
            .ignoresSafeArea(.all)
            
            //VSTACK Button place and lock
            VStack{
                if  isAlreadyLock{
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
                            
                            if let selectedDate = selectedDate {
                                let selectedDatePlus30Minutes = calendar.date(byAdding: .minute, value: 0, to: selectedDate)
                                Slider(value: $sliderValue, in: 7.00...16.00, step: 1)
                                    .padding()
                                    .onChange(of: sliderValue) { newValue in
                                        print("[DEBUG][VALUE]", newValue)
                                        let sunPosition = sunManager.sun?.getSunHorizonCoordinatesFrom(date: selectedDatePlus30Minutes ?? Date())
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
                                        
                                        print("[DEBUG][lightPosition]", lightPosition.orientation_x)
                                    }
                            }
                            
                        }
                        .foregroundColor(.white)
                        .frame(height: 53)
                        .padding()
                        .background(Color(.colorGraySlider))
                        .cornerRadius(16)
                        .padding(.horizontal,30)
                        .padding(.bottom,20 )
                    }
                } else {
                    VStack{
                        Spacer()
                        if !isAlreadyLock && isAlreadyPlace {
                            Text("Place the 3D model in accordance\nwith every corner in your garden")
                                .calloutWhite()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color(.black).opacity(0.7))
                                .cornerRadius(12)
                                .padding(.bottom,80)
                        }
                        HStack{
                            Spacer()
                            
                            Button {
                                viewModel.placeModel()
                                isAlreadyPlace.toggle()
                            } label: {
                                Text("Place 3d Model")
                                    .titleButton()
                            }
                            .padding(.horizontal, 11)
                            .padding(.vertical,12)
                            .background(Color(.black))
                            .cornerRadius(12)
                            .disabled(isAlreadyPlace)
                            
                            
                            
                            
                            Button {
                                isAlreadyLock.toggle()
                            } label: {
                                Text("Lock 3d Model")
                                    .titleButton()
                            }
                            .disabled(!isAlreadyPlace)
                            .padding(.horizontal, 11)
                            .padding(.vertical,12)
                            .background(Color(.black))
                            .cornerRadius(12)
                            
                            Spacer()
                            
                        }
                    }
                    .padding(.bottom, 25)
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

