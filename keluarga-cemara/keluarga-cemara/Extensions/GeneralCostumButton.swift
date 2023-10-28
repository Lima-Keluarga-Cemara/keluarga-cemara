//
//  GeneralCostumButton.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import SwiftUI

struct GeneralCostumButton: View {
    var title : String
    let action : () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack{
                Spacer()
                Text(title)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                Spacer()
                Image(systemName: "chevron.forward.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color(.primaryButton))
                    .padding(.trailing,20)
            }
        })
        .frame(width: 358, height: 56)
        .foregroundColor(.white)
        .background(Color(.black))
        .cornerRadius(16)
    }
}

#Preview {
    GeneralCostumButton(title: "See shade result", action: {})
}
