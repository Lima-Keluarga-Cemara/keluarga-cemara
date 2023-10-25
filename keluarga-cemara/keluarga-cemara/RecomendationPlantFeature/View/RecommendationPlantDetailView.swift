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
            ZStack{
                VStack{
                    Image(plant.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width)
                    Spacer()
                }
                
                VStack{ //handling position on zstack
                    Spacer()
                    ScrollView{
                        VStack(alignment: .leading){ //create card corner
                            Text(plant.title)
                                .font(.system(size: 24))
                                .bold()
                                .padding(.top, 33)
                                .padding(.bottom, 12)
                            
                            Text(plant.description)
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(Color.gray)
                                .padding(.bottom, 24)
                            
                            Text("Plant Care")
                                .font(.system(size: 16))
                                .bold()
                                .padding(.bottom, 13)
                            
                            ForEach(plant.plantCare, id: \.self) { plantCare in
                                CareInfoView(geometry: geometry, plantInfo: plantCare)
                            }
                        }
                        .padding(.horizontal, 31)
                        .background{
                            UnevenRoundedRectangle(topLeadingRadius: 32, topTrailingRadius: 32)
                                .foregroundStyle(.white)
                        }
                        
                    }
                    .frame(width: geometry.size.width, height: 568)
                    .scrollIndicators(.hidden)
                    
                }
            }
            .ignoresSafeArea(.all)
        }
        
    }
}

#Preview {
    RecommendationPlantDetailView(plant: RecommendPlantModel(title: "Pakcoy", description: "deskripsi", image: .pakcoy, type: .fullsun, plantCare: [PlantCareInfo(image: "drop.fill", info: "tester")]))
}

struct CareInfoView: View {
    var geometry: GeometryProxy
    let plantInfo: PlantCareInfo
    
    var body: some View {
        HStack{
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color(.iconTile))
                .frame(width: 37, height: 32)
                .overlay {
                    Image(systemName: plantInfo.image)
                        .foregroundStyle(.white)
                }
            
            Text(plantInfo.info)
                .font(.system(size: 12))
                .fontWeight(.medium)
        }
        .frame(width: geometry.size.width * 0.82) //320
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(Color(.backgroundTile)))
        .padding(.bottom, 12)
    }
}
