//
//  SliderView.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 31/10/23.
//

import SwiftUI

struct SliderView: View {
    @StateObject private var sunManager = LocationManager()
    @State private var selectedTime  : TimeInterval  = 0.0
    @State private var feedbackGenerator : UIImpactFeedbackGenerator? = nil

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
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Text("\(formattedDate(from: selectedTime))")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .bold()
                Spacer()
            }
            CustomSlider(value: Binding(
                get: {
                    self.selectedTime
                },
                set: { value in
                    self.selectedTime = value
                    self.handleSliderChange()
                }
            ), rangeSlide: sunRiseTime...sunSetTime)
            .frame(width: 300, height: 10)
            
        }
        .foregroundColor(.white)
        .frame(height: 53)
        .padding()
        .background(Color(.colorGraySlider))
        .cornerRadius(16)
        .padding(.horizontal,30)
    }
}

#Preview {
    SliderView()
}
