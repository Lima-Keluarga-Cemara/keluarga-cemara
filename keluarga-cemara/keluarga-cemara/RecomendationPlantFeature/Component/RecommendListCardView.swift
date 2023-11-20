//
//  RecommendCardView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 23/10/23.
//

import SwiftUI

struct RecommendListCardView: View {
    @EnvironmentObject private var pathStore: PathStore
    @Environment(\.presentationMode) var presentationMode
    
    let title: String
    let desc : String
    let titleVeggies : String
    let data: [RecommendPlantModel]
    let columnGrid: [GridItem]
    @State var selectedVeggie : RecommendPlantModel?
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 8){
                HStack{
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 28))
                    })
                }
                Text(title)
                    .title1()
                
                Text(desc)
                    .callout()
                    .padding(.bottom,10)
                
                Text(titleVeggies)
                    .title2()
                    .padding(.bottom,4)
                
                LazyVGrid(columns: columnGrid){
                    ForEach(data, id: \.self.id) { plant in
                        RecommendCardView(image: plant.image, plantName: plant.title)
                            .onTapGesture {
                                selectedVeggie = plant
                            }
                            .sheet(item: $selectedVeggie) { veggie in
                                RecommendationPlantDetailView(plant: veggie)
                                    .presentationDetents([.large])
                            }
                    }
                    
                }.padding(.horizontal,16)
            }
            .padding(.horizontal,18)
            .sheet(item: $selectedVeggie) { veggie in
                RecommendationPlantDetailView(plant: veggie)
            }
        }
        
    }
}

#Preview {
    RecommendListCardView(title: "Partial Sun", desc: "This area get 6 or more hours of direct sunlight per day", titleVeggies: "Partial Sun Veggies", data: RecommendPlantMock.separatePlantsByType(.fullsun), columnGrid: [GridItem(.flexible()), GridItem(.flexible())])
}
