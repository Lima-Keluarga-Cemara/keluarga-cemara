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
                        .aspectRatio(contentMode: .fill)
                        .overlay(
                            LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                                           startPoint: .top,
                                           endPoint: .bottom)
                        )
                        .frame(width: 447, height: 415)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width)
                
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
                                .foregroundStyle(Color(.plantDetailSubText))
                                .padding(.bottom, 40)
                            
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
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.68)
                    .scrollIndicators(.hidden)
                    
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    RecommendationPlantDetailView(plant: RecommendPlantMock().cabbagePlant)
}


