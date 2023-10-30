//
//  ItemInstruction.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 30/10/23.
//

import SwiftUI

struct ItemInstruction : View {
    let image : String
    let title : String
    let width : CGFloat
    let height : CGFloat
    let textSize : CGFloat
    let textColor : Color
    
    var body: some View {
        HStack(spacing: 14){
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.iconTile))
                    .frame(width: width, height: height)

                           
                Image(image)
                    
            }
            
            Text(title)
                .font(.system(size: textSize, weight: .semibold, design: .rounded))
                .foregroundColor(textColor)
        }
        .padding(.bottom,12)
        .padding(.horizontal, 22)
    }
}
#Preview {
    ItemInstruction(image: "fifth_icon", title: "Hahaha", width : 44, height : 44 , textSize: 14, textColor: .black)
}
