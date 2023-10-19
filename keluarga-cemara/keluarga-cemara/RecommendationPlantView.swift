//
//  RecommendationPlantView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 17/10/23.
//

import SwiftUI

struct RecommendationPlantView: View {
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView{
            RecommendCardView(title: "Partial Sun Veggies", columnGrid: twoColumnGrid)
            RecommendCardView(title: "Partial Sun Veggies", columnGrid: twoColumnGrid)
        }
    }
}

#Preview {
    RecommendationPlantView()
}

struct CardView: View {
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
                .foregroundStyle(.cardTitle)
                .overlay {
                    Text("Pakcoy")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                }
        }
        .frame(width: 145, height: 156)
        .background(.card)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        .padding(.bottom, 17)
    }
}

struct RecommendCardView: View {
    let title: String
    let columnGrid: [GridItem]
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Partial Sun Veggies")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(11)
            LazyVGrid(columns: columnGrid){
                ForEach(1...4, id: \.self) { _ in
                    CardView()
                }
                
            }
        }.padding(.horizontal, 16)
    }
}
