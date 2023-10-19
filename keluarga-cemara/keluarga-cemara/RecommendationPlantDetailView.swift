//
//  RecommendationPlantDetailView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 17/10/23.
//

import SwiftUI

struct RecommendationPlantDetailView: View {
    var body: some View {
        ZStack{
            VStack{
                Image(.plant)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400)
                Spacer()
            }
            
            VStack{ //handling position on zstack
                Spacer()
                VStack{ //create card corner
                    ScrollView{
                        VStack(alignment: .leading){
                            Text("Pakcoy")
                                .font(.system(size: 24))
                                .bold()
                                .padding(.top, 20)
                                .padding(.bottom, 12)
                            
                            Text("Pakchoi, also known as bok choy or Chinese cabbage, is a popular leafy green vegetable that is not only delicious but also packed with several health benefits such as nutrient rich, low in calories, antioxidant properties, heart health and bone health.")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .padding(.bottom, 24)
                            
                            HStack{
                                Spacer()
                                ForEach(PlantInfo.allCases, id: \.self) { plant in
                                    PlantInfoView(plantData: plant, number: "4 Hours")
                                }
                                Spacer()
                            }
                            .padding(.bottom, 24)
                            
                            Text("Cara Perawatan")
                                .font(.system(size: 16))
                                .bold()
                                .padding(.bottom, 13)
                            
                            ForEach(1...4, id: \.self) { _ in
                                CareInfoView()
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.horizontal, 31)
                .background{
                    UnevenRoundedRectangle(topLeadingRadius: 32, topTrailingRadius: 32)
                        .foregroundStyle(.white)
                }
                .frame(width: 390, height: 568)
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    RecommendationPlantDetailView()
}

struct CareInfoView: View {
    var body: some View {
        HStack{
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.iconTile)
                .frame(width: 37, height: 32)
                .overlay {
                    Image(systemName: "drop.fill")
                        .foregroundStyle(.white)
                }
            
            Text("Menanam biji pakcoy dengan jarak yang cukup")
                .font(.system(size: 12))
                .fontWeight(.medium)
        }
        .frame(width: 320, height: 46)
        .padding(.horizontal, 10)
        .background(RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(.backgroundTile))
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
                .padding(.vertical, 6)
            
            Text(plantData.rawValue)
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .padding(.bottom, 4)
            
            Text(number)
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .padding(.bottom, 6)
        }
        .foregroundStyle(.white)
        .frame(width: 79, height: 75)
        .background(.bacgroundTilePrimary)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.trailing, 15)
    }
}
