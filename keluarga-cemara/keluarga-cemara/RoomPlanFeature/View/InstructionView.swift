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
            Image(.bgInstruction)
                .resizable()
                .ignoresSafeArea()
            
            
            VStack(alignment: .leading){
                Text("To start your gardening \njourney, you need to:")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.bottom, 25)
                    .padding(.leading, 30)
                
                VStack(alignment: .leading, spacing: 14){
                    ItemInstruction(image: .firstIcon, title: "1. Be on your area.",subTitle: "Bring your phone to the area where you will start gardening.", width: 72 , height: 69, textSize: 16, textColor: .white)
                    
                    ItemInstruction(image: .secondIcon, title: "2. Facing sunlight come.", subTitle: "Hold your phone and stand facing the side where sunlight comes in your garden area.", width: 72 , height: 69, textSize: 16, textColor: .white)
                    
                    ItemInstruction(image: .fourthIcon, title: "3. Start Scaning", subTitle: "When you sure of the direction where sunlight comes, start scanning.", width: 72 , height: 69, textSize: 16, textColor: .white)
                    
                }
                
                Spacer()
                
                HStack{
                    Spacer()
                    GeneralCostumButton(title: "Scan garden area") {
                        feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                        feedbackGenerator?.impactOccurred()
                        pathStore.navigateToView(.roomscan)
                        locationManager.resultOrientationDirection = locationManager.orientationGarden
                      
                    }
                    Spacer()
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    InstructionView()
}
