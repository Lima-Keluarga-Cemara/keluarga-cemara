//
//  SliderView.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/11/23.
//

import SwiftUI
//costum slider for time with time indicator
struct TimeSlider: View {
    @Binding var sliderValue: Double
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var lightPosition = LightPosition()
    
    let date = Date()
    var calendar = Calendar.current
    let timeValue: [Double] = [06.00, 08.00, 10.00, 12.00, 13.00, 15.00, 17.00]
    
    var selectedDate: Date? {
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = Int(sliderValue) // format 24 hours
        return calendar.date(from: dateComponents)
    }
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 356, height: 92)
                .foregroundColor(.gray)
                .cornerRadius(10)
            
            VStack{
                if let selectedDate = selectedDate {
                    let selectedDatePlus30Minutes = calendar.date(byAdding: .minute, value: 0, to: selectedDate)
                    Slider(value: $sliderValue, in: 05.00...17.00)
                        .accentColor(.white)
                        .padding(.horizontal, 25)
                        .onChange(of: sliderValue) { newValue in
                            
                            let sunPosition = locationManager.sun?.getSunHorizonCoordinatesFrom(date: selectedDatePlus30Minutes ?? Date())
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
                        }
                }
                HStack {
                    Text("All")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                    ForEach(timeValue, id: \.self) { value in
                        Text("\(Int(value))")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .padding(.horizontal, 11)
                    }
                    
                    
                }
                
            }
        }
    }
}
