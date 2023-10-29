//
//  CustomSlider.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 28/10/23.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var value : Double
    @State var lastCoordinateValue : CGFloat = 0.0
    var rangeSlide : ClosedRange<Double>
    
    
    var body: some View {
        GeometryReader(content: { geo in
            let thumbSize = geo.size.height * 0.8
            let radius = geo.size.height * 0.5
            let minValue = geo.size.width * 0.015
            let maxValue = (geo.size.width * 0.98) - thumbSize
            
            let scaleFactor = (maxValue - minValue) / (rangeSlide.upperBound - rangeSlide.lowerBound)
            let lower = rangeSlide.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor + minValue
            
            
            ZStack {
                RoundedRectangle(cornerRadius: radius)
                    .foregroundColor(Color(.primaryButton))
                HStack {
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color.white)
                        .frame(width: thumbSize, height: thumbSize)
                        .offset(x: sliderVal)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { v in
                                    if (abs(v.translation.width) < 0.1) {
                                        self.lastCoordinateValue = sliderVal
                                    }
                                    if v.translation.width > 0 {
                                        let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor)  + lower
                                    } else {
                                        let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                    }
                                    
                                }
                        )
                    Spacer()
                }
            }
        })
    }
}

#Preview {
    CustomSlider(value: .constant(0.0), rangeSlide: 1...10)
}
