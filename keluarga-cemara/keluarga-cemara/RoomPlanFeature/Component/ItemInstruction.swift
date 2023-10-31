//
//  ItemInstruction.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 30/10/23.
//

import SwiftUI

struct ItemInstruction : View {
    let image : ImageResource
    let title : String
    let subTitle : String?
    let width : CGFloat
    let height : CGFloat
    let textSize : CGFloat
    let textColor : Color
    
    var body: some View {
        HStack(spacing: 14){
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.iconTile))
                Image(image)
                    
            }
            .frame(width: width, height: height)

            
            VStack(alignment : .leading){
                Text(title)
                    .font(.system(size: textSize, weight: .semibold, design: .rounded))
                    .foregroundColor(textColor)
                
                Text(subTitle ?? "")
                    .font(.system(size: 11, weight: .regular, design: .rounded))
                    .foregroundColor(textColor)
                    .padding(.leading)
                
            }
        }
        .padding(.horizontal, 22)
    }
}
#Preview {
    ItemInstruction(image: .fifthIcon, title: "1. Be on your area", subTitle: "Bring your phone to the area where you will start gardening.", width : 44, height : 44 , textSize: 14, textColor: .black)
}
