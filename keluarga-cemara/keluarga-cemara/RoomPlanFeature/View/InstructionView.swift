//
//  InstructionView.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 10/11/23.
//

import SwiftUI

struct InstructionView: View {
    private var cameraModel = CameraModel()
    @StateObject private var sunManager = LocationManager()
    @EnvironmentObject private var pathStore: PathStore

    var body: some View {
        VStack(spacing : 0){
//            MARK: Header
            ZStack{
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 100)
                
                HStack{
                    Spacer()
                    Button("Next") {
                        DispatchQueue.main.async {
                            pathStore.navigateToView(.roomscan)
                            sunManager.resultOrientationDirection = sunManager.orientationGarden
                        }
                    }
                }
                .padding(.horizontal, 21)
                .padding(.top, 20)
            }
//            MARK: Content
            ZStack{
                CameraRepresentable(cameraModel: cameraModel)
                    .ignoresSafeArea()
                
                VStack{
                    Text("Facing \(sunManager.direction) side")
                        .callout()
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color(.primaryButton))  
                        .cornerRadius(12)
                        .padding(.top,13)
                    
                    Spacer()
                    VStack(alignment : .center , content: {
                        LottieView(loopMode: .loop, resource: "instruksi-opening.json")
                            .frame(width: 100, height: 100)
                            .padding(.bottom, 32)
                        
                        Text("Bring phone to garden area and face \nit to the side where sunlight comes in")
                            .textInstruction()
                            .multilineTextAlignment(.center)
                            
                    })
                    Spacer()
                }
            }
            

//            MARK: Button Disabled
            ZStack{
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 150)
                
                Button(action: {
                    
                }, label: {
                    Image(.disableButtonRecord)
                        .font(.system(size: 63))
                        .padding(.bottom,30)
                })
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        
        
    }
}

#Preview {
    InstructionView()
}
