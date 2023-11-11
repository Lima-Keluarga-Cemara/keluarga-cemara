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
    var isShowIcon : Bool = false
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack{
                Spacer()
                Text(title)
                    .titleButton()
                
                Spacer()
                if isShowIcon{
                    Image(systemName: "chevron.forward.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color(.primaryButton))
                    .padding(.trailing,20)
                }
                   
            }
        })
       
        .frame(width: 361, height: 58)
        .foregroundColor(.white)
        .background(Color(.black))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    GeneralCostumButton(title: "See shade result", action: {})
}
