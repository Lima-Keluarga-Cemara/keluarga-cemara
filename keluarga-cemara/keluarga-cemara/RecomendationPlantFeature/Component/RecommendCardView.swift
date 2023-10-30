//
//  RecommendCardView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 23/10/23.
//

import SwiftUI

struct RecommendCardView: View {
    let image: ImageResource
    let plantName: String
    
    var body: some View {
        VStack(spacing: 0){
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 146, height: 114)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12))
            
            VStack(alignment: .leading){
                Text(plantName)
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                
                Text("Bisa dipanen 120 hari setelah penanaman")
                    .font(.system(size: 11))
                    .foregroundStyle(Color(.cardSubText))
                    .fontWeight(.regular)
            }
            .frame(width: 146, height: 72)
            .background(Color(.card))
            .clipShape(
                UnevenRoundedRectangle(bottomLeadingRadius: 12, bottomTrailingRadius: 12)
            )
        }
        .frame(width: 146, height: 186)
        .shadow(radius: 5, x: 1, y: 6)
        .padding(.horizontal, 8)
        .padding(.bottom, 17)
    }
}

#Preview {
    RecommendCardView(image: .bokcoy, plantName: "Pakcoy")
}
