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
    @State private var isDetailSheetPresented = false // Add a state variable to control the presentation of the detail sheet

    
    let title: String
    let data: [RecommendPlantModel]
    let columnGrid: [GridItem]
    @State var selectedVeggie : RecommendPlantModel?

    var body: some View {
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
            
            Text("This area gets 4-6 hours of direct sunlight per day")
                .callout()
            
            Text("Partial Sun Veggies")
                .title2()
                .padding(.bottom,4)
            
            LazyVGrid(columns: columnGrid){
                ForEach(data, id: \.self) { plant in
                    RecommendCardView(image: plant.image, plantName: plant.title)
                        .onTapGesture {
                           selectedVeggie = plant
                            isDetailSheetPresented.toggle()
                        }
                        .sheet(isPresented: $isDetailSheetPresented) {
                            if let plant  = selectedVeggie {
                                RecommendationPlantDetailView(plant: plant)
                            }
                        }
                }
                
            }.padding(.horizontal,10)
        }
        .padding(.horizontal,18)
        
    }
}

#Preview {
    RecommendListCardView(title: "Partial Sun", data: [RecommendPlantMock().celeryPlant, RecommendPlantMock().cabbagePlant], columnGrid: [GridItem(.flexible()), GridItem(.flexible())])
}
