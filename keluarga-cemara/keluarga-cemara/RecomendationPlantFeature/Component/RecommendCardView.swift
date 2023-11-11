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
                .frame(width: 146, height: 156)
                .aspectRatio(contentMode: .fit)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12))
            
            HStack{
                Text(plantName)
                    .callout()
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                Spacer()
            }
            .frame(width: 146, height: 42)
            .background(Color(.iconTile))
            .clipShape(
                UnevenRoundedRectangle(bottomLeadingRadius: 12, bottomTrailingRadius: 12)
            )
        }
        .shadow(color : Color.black.opacity(0.2), radius: 6, x: 1, y: 6)
        .padding(.horizontal, 8)
        .padding(.bottom, 17)
        
    }
}

#Preview {
    RecommendCardView(image: .bokcoy, plantName: "Pakcoy")
}
