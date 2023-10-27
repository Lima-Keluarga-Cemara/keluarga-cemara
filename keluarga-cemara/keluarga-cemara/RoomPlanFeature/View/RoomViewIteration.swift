//
//  RoomViewIteration.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 27/10/23.
//

import SwiftUI

struct RoomViewIteration: View {
    @EnvironmentObject private var pathStore: PathStore
    @StateObject private var roomController = RoomController.instance
    @Environment(\.dismiss) private var dismiss
    @State private var isStartScanning : Bool = false
    
    var body: some View {
        VStack{
//            MARK: Navbar instruction nd exit
            ZStack{
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 100)
                
                HStack{
                    Button("Instruction") {
//                            add action for sheet
                    }
                    
                    Spacer()
                    
                    Button("Exit") {
//                            add action for action sheet cancel
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
            }
//            MARK: camera of roomplan
            if isStartScanning{
                RoomViewRepresentable()
            } else {
                VStack{
                    Text("You’re orientation facing north")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(12)
                        .padding(.top,12)
                    Spacer()
                }
            }
//            MARK: button start and stop session
            ZStack{
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 150)
                
                Button(action: {
                    if isStartScanning{
                        roomController.stopSession()
                        isStartScanning = false
                    } else {
                        roomController.startSession()
                        isStartScanning = true
                    }
                }, label: {
                    Image(systemName: isStartScanning ? "stop.circle" : "circle.inset.filled")
                        .foregroundColor( .white )
                        .font(.system(size: 64))
                })
                
            }
            
        }
        .background(Blur(style: .systemUltraThinMaterialDark))
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
        
}

#Preview {
    RoomViewIteration()
}

struct Blur : UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
        func makeUIView(context: Context) -> UIVisualEffectView {
            return UIVisualEffectView(effect: UIBlurEffect(style: style))
        }
        func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
            uiView.effect = UIBlurEffect(style: style)
        }
}
