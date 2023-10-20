//
//  ButtonRoomPlan.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import SwiftUI


struct ButtonStyleRoomPlan : ButtonStyle {
    var widthButton : CGFloat?
    
    func makeBody(configuration : Configuration) -> some View{
        configuration
            .label
            .padding()
            .foregroundColor(.white)
            .frame(width: widthButton, height: 32)
            .background(Color.greyColor.opacity(0.4))
            .cornerRadius(20)
    }
}
