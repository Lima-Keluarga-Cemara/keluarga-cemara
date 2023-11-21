//
//  ButtonCustom.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/11/23.
//

import SwiftUI

struct ButtonCustom: View {
    var title : String
    let action : () -> Void
    let width : CGFloat
    let height : CGFloat
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .titleButtonBlack()
        })
        .padding()
        .frame(width: width, height: height)
        .background(Color(.whiteButton))
        .cornerRadius(12)        
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)

    }
}

#Preview {
    ButtonCustom(title: "Next", action: {}, width: 116 , height: 44)
        .ignoresSafeArea()
}
