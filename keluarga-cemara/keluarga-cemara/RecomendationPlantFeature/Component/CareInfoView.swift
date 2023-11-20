//
//  CareInfoView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 28/10/23.
//

import SwiftUI

struct CareInfoView: View {
    var geometry: GeometryProxy
    let plantInfo: PlantCareInfo
    
    var body: some View {
        HStack{
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color(.iconTile))
                .frame(width: 56, height: 44)
                .overlay {
                    Image(systemName: plantInfo.typeCareInfo.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 27, height: 27)
                        .foregroundStyle(.white)
                }
            
            VStack(alignment: .leading){
                Text(plantInfo.typeCareInfo.rawValue.capitalized)
                    .titleCapt()
                Text(plantInfo.info)
                    .descCapt()
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .fixedSize(horizontal: false, vertical: true) // Allow the text to wrap to the next line
            }
            
            Spacer()
        }
        .frame(width: geometry.size.width * 0.90) //320
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(Color(.backgroundTile)))
        .padding(.bottom, 12)
    }
}

#Preview {
    GeometryReader { geometry in
        CareInfoView(geometry: geometry, plantInfo: RecommendPlantMock().endivePlant.plantCare[2])
    }
}
