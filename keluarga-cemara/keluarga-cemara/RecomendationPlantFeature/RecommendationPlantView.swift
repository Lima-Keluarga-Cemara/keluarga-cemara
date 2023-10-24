//
//  RecommendationPlantView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 17/10/23.
//

import SwiftUI

struct RecommendationPlantView: View {
    @EnvironmentObject private var pathStore: PathStore
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView{
            RecommendListCardView(title: "Partial Sun Veggies", columnGrid: twoColumnGrid) {
                pathStore.navigateToView(.plantrecomenddetail)
            }
            RecommendListCardView(title: "Partial Sun Veggies", columnGrid: twoColumnGrid) {
                pathStore.navigateToView(.plantrecomenddetail)
            }
        }
        .navigationTitle("Recommendation")
    }
}

#Preview {
    RecommendationPlantView()
}
