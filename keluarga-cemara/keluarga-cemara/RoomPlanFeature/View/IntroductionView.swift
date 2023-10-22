//
//  IntroductionView.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import SwiftUI

struct IntroductionView: View {
    @EnvironmentObject private var pathStore: PathStore
    @State private var isImageVisible  : Bool = false
    
    var body: some View {
        ZStack{
            Color(.backgroundGreen)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false){
                VStack{
                    Image("ilustrasi_one")
                        .resizable()
                        .frame(width: 450, height: 450)
                        .offset(x: isImageVisible ? -70 : -410, y: -70)
                        .transition(.move(edge: .leading))
                        .animation(.easeIn(duration: 4), value: isImageVisible)
                    
                    textExplanation(title: "Scan your whole garden area", description: "move your phone camera towards\nevery corner of your garden area", aligment: .trailing)
                        .multilineTextAlignment(.trailing)
                        .offset(x: isImageVisible ? 20 : 390, y: -60)
                        .transition(.move(edge: .trailing))
                        .animation(.easeIn(duration: 4), value: isImageVisible)

                    
                    Image("ilustrasi_two")
                        .resizable()
                        .frame(width: 500, height: 500)
                        .offset(x:isImageVisible ? 80 : 410, y: -30)
                        .transition(.move(edge: .trailing))
                        .animation(.easeIn(duration: 4), value: isImageVisible)

                    
                    textExplanation(title: "Build 3D model of your garden area", description: "get the result to help you mapping the\nsunlight in your garden easier ", aligment: .leading)
                        .multilineTextAlignment(.leading)
                        .offset(x: isImageVisible ? 0 : -410, y : -20)
                        .padding(.bottom, 65)
                        .transition(.move(edge: .leading))
                        .animation(.easeIn(duration: 4), value: isImageVisible)
                    
                    GeneralCostumButton(title: "Scan garden area") {
                        pathStore.navigateToView(.roomscan)
                    }
                }
                .onAppear{
                    isImageVisible = true
                }
               
               
            }
        }
       
    }
    
    @ViewBuilder
    func textExplanation( title : String,  description : String, aligment : HorizontalAlignment) -> some View{
        VStack(alignment: aligment){
            Text(title)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .padding(.bottom,3)
            
            Text(description)
                .font(.system(size: 14, weight: .regular, design: .rounded))
        }
    }
}

#Preview {
    IntroductionView()
}
