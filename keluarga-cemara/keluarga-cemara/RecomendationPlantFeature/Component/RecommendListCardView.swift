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
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(11)
            LazyVGrid(columns: columnGrid){
                ForEach(data, id: \.self) { plant in
                    RecommendCardView(image: plant.image, plantName: plant.title)
                        .onTapGesture {
                            pathStore.navigateToView(.plantrecomenddetail(plant))
                        }
                }
                
            }
        }.padding(.horizontal, 16)
    }
}

#Preview {
    RecommendListCardView(title: "Partial Sun", data: [RecommendPlantModel(title: "Pakcoy", description: "deskripsi", image: .pakcoy, type: .fullsun, plantCare: [PlantCareInfo(image: "drop.fill", info: "tester")])], columnGrid: [GridItem(.flexible()), GridItem(.flexible())])
}
