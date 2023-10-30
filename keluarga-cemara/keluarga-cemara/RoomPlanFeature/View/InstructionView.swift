//
//  InstructionView.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 30/10/23.
//

import SwiftUI

struct InstructionView: View {
    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject private var pathStore: PathStore
    @State private var feedbackGenerator: UIImpactFeedbackGenerator?

    var body: some View {
        ZStack{
            Image("instruction_image")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                Text("To start your gardening \njourney, you need to:")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.bottom, 26)
                    .padding(.trailing, 70)
                
                VStack(alignment: .leading, spacing: 15){
                    ItemInstruction(image: "first_icon", title: "1. Bring your phone to the area where you will start gardening", width: 72 , height: 69, textSize: 16, textColor: .white)
                    
                    ItemInstruction(image: "second_icon", title: "2. Direct your phone towards the side where sunlight comes", width: 72 , height: 69, textSize: 16, textColor: .white)
                }
                
                Spacer()
                
                GeneralCostumButton(title: "Scan garden area") {
                    feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                    feedbackGenerator?.impactOccurred()
                    pathStore.navigateToView(.roomscan)
                    locationManager.resultOrientationDirection = locationManager.orientationGarden
                  
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    InstructionView()
}
