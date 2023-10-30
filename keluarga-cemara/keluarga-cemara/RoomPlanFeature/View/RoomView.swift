//
//  RoomView.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import SwiftUI

struct RoomView: View {
    @EnvironmentObject private var pathStore: PathStore
    @StateObject private var roomController = RoomController.instance
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        ZStack{
            RoomViewRepresentable()
                .onAppear(perform: {
                    roomController.startSession()
                })
            
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color(.blackCamera))
                        .frame(height: 150)
                    HStack{
        //                MARK: Button back
                        Button(action: {
                            print("back")
                            dismiss()
                            roomController.stopSession()
                            
                        }, label: {
                            Image(systemName: "chevron.backward")
                        })
                        .buttonStyle(.plain)
                       
                        Spacer()
        //                MARK: Button done
                        Button(action: {
                        print("done")
                        roomController.stopSession()
                        pathStore.navigateToView(.resultfeature)
                        }, label: {
                            Text("Done")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                        })
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 60)
                }
                
                Spacer()
                
                Rectangle()
                    .fill(Color(.blackCamera))
                    .frame(height: 220)
                
            }
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

#Preview {
    RoomView()
}
