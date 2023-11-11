//
//  ResultScan.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import SwiftUI
import SceneKit

struct ResultScan: View {
    @EnvironmentObject private var pathStore: PathStore
    @State private var isLoading : Bool = true
    @State private var selectedTime  : TimeInterval  = 0.0
    @State private var sceneObject : SCNScene? = .init(named: "scan.usdz")
    @StateObject private var sunManager = LocationManager()
    //    add this for haptip
    @State private var feedbackGenerator : UIImpactFeedbackGenerator? = nil
    //    try add this variable to set azimut angle and the height of object
    @State private var azimuthAngle  : Double  = 0.0
    @State private var objectHeight : Double = 5.0
    
    func formattedDate(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSinceNow: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "hh a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: date)
    }
    
    var sunRiseTime : TimeInterval {
        let timeSunrise  = sunManager.sun?.sunrise.timeIntervalSinceNow ?? 0.0
        return timeSunrise
    }
    
    var sunSetTime : TimeInterval {
        let timeSunset  = sunManager.sun?.sunset.timeIntervalSinceNow ?? 0.0
        return timeSunset
    }
    
    func handleSliderChange(){
        let calender = Calendar.current
        let previuosTime = Date(timeIntervalSinceNow: selectedTime - 3600)
        let currentTime = Date(timeIntervalSinceNow: selectedTime)
        if calender.component(.hour, from: previuosTime) != calender.component(.hour, from: currentTime) {
            feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator?.impactOccurred()
        }
    }
    
    var body: some View {
        ZStack{

            VStack(spacing: 20){
                
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        Text("\(formattedDate(from: selectedTime))")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .bold()
                        Spacer()
                    }
                                    
                    Slider(value: Binding(
                        get: {
                            self.selectedTime
                        },
                        set: { value in
                            self.selectedTime = value
                            self.handleSliderChange()
                        }), in: sunRiseTime...sunSetTime)
                    .tint(.yellow)
                    
                }
                .foregroundColor(.white)
                .frame(height: 53)
                .padding()
                .background(Color(.colorGraySlider))
                .cornerRadius(16)
                .padding(.horizontal,30)
                
                if isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.gray))
                        .scaleEffect(4)
                        .frame( height: UIScreen.main.bounds.height / 2 )
                    
                } else {
                    CustomSceneViewRepresentable(
                        isLoading: $isLoading,
                        sceneObject: $sceneObject,
                        azimuthAngle: $selectedTime)
                    .frame(height: 400)
                    
                    
                }
                
                Text("\(sunManager.resultOrientationDirection ?? "Partial Sun")")
                    .calloutWhite()
                    .multilineTextAlignment(.center)
                    .frame(width: 239, height: 67)
                    .padding()
                    .background(Color(.grayTextResultOrientation))
                    .cornerRadius(14)
                
                GeneralCostumButton(title: "See shade result", action: {
                    pathStore.navigateToView(.arview)
                } )
                
            }
        }
        .onAppear(perform: {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2.0, execute: {
                isLoading = false
                print("sunrisetime \(sunRiseTime)")
            })
        })
        
    }
}

#Preview {
    ResultScan()
}




