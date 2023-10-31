//
//  ButtonMenu.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 31/10/23.
//

import SwiftUI

struct ButtonMenu: View {
    @Binding var action : Bool
    let title : String
    var body: some View {
        Button(action: {
            action.toggle()
            print("show shade info")
        }, label: {
            HStack{
                Text(title)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Image(systemName: action ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(action ? .blue : .white)
                    .font(.system(size: 20))
            }
        })
    }
}

#Preview {
    ButtonMenu(action: .constant(true), title: "Hahahaha")
        .background(Color.red)
}
