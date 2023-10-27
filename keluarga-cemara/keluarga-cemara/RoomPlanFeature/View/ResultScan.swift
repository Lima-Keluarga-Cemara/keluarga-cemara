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
    
   
    
    /**
     - get data sunrise date nya dulu
     - get data sunset datenya dulu
     - buat range waktu antara sunrise dan sunset
     */
    
    
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
            LinearGradient(colors: [Color(.firstGradientOrange), Color(.secondGradientOrange), Color(.thirdGradientOrange)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            
            VStack(spacing: 20){
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        Text("\(formattedDate(from: selectedTime))")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    
                    HStack{
                        VStack{
                            Image(systemName: "sunrise")
                            Text("\(formattedDate(from: sunRiseTime))")
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
                        VStack{
                            Image(systemName: "sunset")
                            Text("\(formattedDate(from: sunSetTime))")
                        }
                    }
                    
                    
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.gray.opacity(0.7))
                .cornerRadius(20)
                .padding(.horizontal,24)
                
                
                if isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(.primaryGreen)))
                        .scaleEffect(4)
                        .frame( height: UIScreen.main.bounds.height / 2 )
                    
                } else {
                    CustomSceneViewRepresentable(
                        isLoading: $isLoading,
                        sceneObject: $sceneObject,
                        azimuthAngle: $selectedTime)
                        .frame(height: 500)
                    
                }
                
                GeneralCostumButton(title: "Start mapping the sun light", action: {
                    print("Testing")
                } )
                
            }
            .padding(.top, 20)
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




