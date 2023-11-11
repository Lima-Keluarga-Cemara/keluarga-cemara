//
//  RecommendationPlantDetailView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 17/10/23.
//

import SwiftUI

struct RecommendationPlantDetailView: View {
    var plant: RecommendPlantModel
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                Image(plant.image)
                    .resizable()
                    .frame(width: geometry.size.width, height: 182)
                    .cornerRadius(16)
                    .padding(.top,27)
                
                VStack(alignment: .leading, spacing: 24){ //create card corner
                    VStack(alignment: .leading){
                        Text(plant.title)
                            .title1()
                            .padding(.top,16)
                            .padding(.bottom,2)
                        
                        Text(plant.description)
                            .callout()
                    }
                    
                    VStack(alignment : .leading){
                        Text("Plant Care")
                            .title2()
                            .padding(.bottom,16)
                            
                        
                        ForEach(plant.plantCare, id: \.self) { plantCare in
                            CareInfoView(geometry: geometry, plantInfo: plantCare)
                        }
                    }
                }
            }
            
        }
        .ignoresSafeArea()
        .padding(.horizontal,16)
    }
}

#Preview {
    RecommendationPlantDetailView(plant: RecommendPlantMock().cabbagePlant)
}


