//
//  RecommendationPlantDetailView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 17/10/23.
//

import SwiftUI

struct RecommendationPlantDetailView: View {
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                VStack{
                    Image(.plant)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width)
                    Spacer()
                }
                
                VStack{ //handling position on zstack
                    Spacer()
                    ScrollView{
                        VStack(alignment: .leading){ //create card corner
                            Text("Pakcoy")
                                .font(.system(size: 24))
                                .bold()
                                .padding(.top, 33)
                                .padding(.bottom, 12)
                            
                            Text("Pakchoi, also known as bok choy or Chinese cabbage, is a popular leafy green vegetable that is not only delicious but also packed with several health benefits such as nutrient rich, low in calories, antioxidant properties, heart health and bone health.")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(Color.gray)
                                .padding(.bottom, 24)
                            
                            HStack{
                                Spacer()
                                ForEach(PlantInfo.allCases, id: \.self) { plant in
                                    PlantInfoView(plantData: plant, number: "4 Hours")
                                }
                                Spacer()
                            }
                            .padding(.bottom, 24)
                            
                            Text("Plant Care")
                                .font(.system(size: 16))
                                .bold()
                                .padding(.bottom, 13)
                            
                            ForEach(1...4, id: \.self) { _ in
                                CareInfoView(geometry: geometry)
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
    RecommendationPlantDetailView()
}

struct CareInfoView: View {
    var geometry: GeometryProxy
    
    var body: some View {
        HStack{
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color(.iconTile))
                .frame(width: 37, height: 32)
                .overlay {
                    Image(systemName: "drop.fill")
                        .foregroundStyle(.white)
                }
            
            Text("Menanam biji pakcoy dengan jarak yang cukup")
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

enum PlantInfo: String, CaseIterable{
    case sunlight
    case temperature
    case pot
    
    var imageName: String{
        switch self {
        case .sunlight:
            return "sun.max.fill"
        case .temperature:
            return "thermometer.sun.fill"
        case .pot:
            return "cloud.rain.fill"
        }
    }
}

struct PlantInfoView: View {
    let plantData: PlantInfo
    let number: String
    
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: plantData.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 19.62, height: 19.65)
                .padding(.top, 10)
                .padding(.bottom, 4)
            
            Text(plantData.rawValue.capitalized)
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .padding(.bottom, 6)
            
            Text(number)
                .font(.system(size: 12))
                .fontWeight(.medium)
                .padding(.bottom, 6)
        }
        .foregroundStyle(.white)
        .frame(width: 90, height: 86)
        .background(Color(.bacgroundTilePrimary))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.trailing, 15)
    }
}
