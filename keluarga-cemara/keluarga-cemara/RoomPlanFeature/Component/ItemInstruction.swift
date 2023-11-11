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
   
    
    var body: some View {
        HStack(spacing: 14){
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.primaryButton))
                Image(image)
                    
            }
            .frame(width: 82, height: 69)

            
            Text(title)
                .bodyInstruction()
        }
    }
}
#Preview {
    ItemInstruction(image: .firstIcon, title: "1. Tap ‘Record button’ to start scanning every corner of your garden area.")
}
