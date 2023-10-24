//
//  RecommendCardView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 23/10/23.
//

import SwiftUI

struct RecommendCardView: View {
    var body: some View {
        VStack{
            Spacer()
            Image(.pakcoy)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 104)
            Spacer()
            UnevenRoundedRectangle(bottomLeadingRadius: 12, bottomTrailingRadius: 12)
                .frame(height: 40)
                .foregroundStyle(Color(.cardTitle))
                .overlay {
                    Text("Pakcoy")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                }
        }
        .frame(width: 145, height: 156)
        .background(Color(.card))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        .shadow(radius: 5, x: 1, y: 6)
        .padding(.bottom, 17)
    }
}

#Preview {
    RecommendCardView()
}
