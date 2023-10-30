//
//  RecommendCardView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 23/10/23.
//

import SwiftUI

struct RecommendListCardView: View {
    @EnvironmentObject private var pathStore: PathStore
    
    let title: String
    let data: [RecommendPlantModel]
    let columnGrid: [GridItem]

    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.system(size: 22))
                .fontWeight(.bold)
                .padding(11)
            LazyVGrid(columns: columnGrid){
                ForEach(data, id: \.self) { plant in
                    RecommendCardView(image: plant.image, plantName: plant.title)
                        .onTapGesture {
                            pathStore.navigateToView(.plantrecomenddetail(plant))
                        }
                }
                
            }.padding(.horizontal, 24)
        }.padding(.horizontal, 11)
    }
}

#Preview {
    RecommendListCardView(title: "Partial Sun", data: [RecommendPlantMock().bokcoyPlant, RecommendPlantMock().cabbagePlant], columnGrid: [GridItem(.flexible()), GridItem(.flexible())])
}
