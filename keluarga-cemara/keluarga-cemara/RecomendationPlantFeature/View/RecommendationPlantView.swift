//
//  RecommendationPlantView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 17/10/23.
//

import SwiftUI

struct RecommendationPlantView: View {
    @EnvironmentObject private var pathStore: PathStore
    @AppStorage("typeOfPlant") var typeOfPlant: TypeOfPlant = .fullsun
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    // MARK: This is mock plant data
    let plantData = RecommendPlantMock.separatePlantsByType()
    
    var body: some View {
        ScrollView{
            ForEach(TypeOfPlant.allCases, id: \.self) { plantType in
                if let plants = plantData[plantType] {
                    RecommendListCardView(title: plantType.title, data: plants, columnGrid: twoColumnGrid)
                }
            }
        }
        .onAppear{
            print("this is app storage, \(typeOfPlant)")
        }
        .navigationTitle("Recommendation")
    }
}

#Preview {
    RecommendationPlantView()
}
