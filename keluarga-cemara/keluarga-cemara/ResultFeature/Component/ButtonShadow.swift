//
//  ButtonShadow.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 20/11/23.
//

import SwiftUI

struct ModalSheetColor : View {
    @State private var isRecommendationPlantSheetPresented: [Bool] = [false, false, false, false]
    @State private var selectedModel : ModelDataButton? = nil

    let buttonData = [
        (title: "Full \nshade",
         typePlant: TypeOfPlant.fullshade,
         arrayColor: [Color(.firtsShadow),Color(.secondShadow)],
         desc: "This area gets less than 2 hours of sunlight per day.",
         veggieType: "Shade Veggies", titleModel : "Shade"
         ),
        
        (title: "Partial \nshade", typePlant: TypeOfPlant.partialshade, arrayColor: [Color(.secondShadow), Color(.thirdShadow)], desc: "This area gets 2-4 hours of direct sunlight per day.", veggieType: "Partial Shade Veggies", titleModel : "Partial Shade"),
        
        (title: "Partial \nsun", typePlant: TypeOfPlant.partialsun, arrayColor: [Color(.thirdShadow), Color(.fourthShadow)], desc: "This area gets 4-6 hours of direct sunlight per day.", veggieType: "Partial Sun Veggies",  titleModel : "Partial Sun"),
        
        (title: "Full sun", typePlant: TypeOfPlant.fullsun, arrayColor: [Color(.fourthShadow), Color(.fifthShadow), Color(.sixthShadow), Color(.seventhShadow)], desc: "This area gets 6 or more hours of direct sunlight per day.", veggieType: "Full Sun Veggies", titleModel : "Full Sun")
    ]
    
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment : .leading){
                
                Text("Shade indicator")
                    .titleInstruction()
                    .padding(.bottom,12)
                
                HStack{
                    ForEach(0..<buttonData.count) { index in
                        ButtonShadow(action: {
                            isRecommendationPlantSheetPresented[index].toggle()
                        }, title: buttonData[index].title, typePlant: buttonData[index].typePlant, arrayColor: buttonData[index].arrayColor)
                        .sheet(isPresented: $isRecommendationPlantSheetPresented[index]) {
                            RecommendListCardView(
                                title: buttonData[index].titleModel,
                                desc: buttonData[index].desc,
                                titleVeggies: buttonData[index].veggieType,
                                data: RecommendPlantMock.separatePlantsByType(buttonData[index].typePlant),
                                columnGrid: [GridItem(.flexible()), GridItem(.flexible())]
                            )
                            .presentationDetents([.height(370)])
                        }
                    }
                    
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                
            }
            .padding(.horizontal,16)
            .padding(.bottom)
            .background(Color.white)
        }
        
        
    }
}

struct ModelDataButton : Identifiable {
    let id = UUID().uuidString
    let title : String
}

#Preview(body: {
    ModalSheetColor()
})

struct ButtonShadow : View {
    let action : () -> Void
    let title : String
    let typePlant : TypeOfPlant
    let arrayColor : [Color]
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(.white))
                .frame(width: 77, height: 77)
                .background(
                    LinearGradient(gradient: Gradient(colors: arrayColor), startPoint: .leading, endPoint: .trailing)
                    
                )
                .cornerRadius(9)
        })
    }
}
