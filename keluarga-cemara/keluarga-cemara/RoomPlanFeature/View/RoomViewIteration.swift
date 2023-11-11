//
//  RoomViewIteration.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 27/10/23.
//

import SwiftUI

struct RoomViewIteration: View {
    @StateObject private var roomVm = RoomViewModel()
    @EnvironmentObject  var pathStore: PathStore

    var body: some View {
        VStack(spacing : 0){
            //            MARK: Navbar instruction nd exit
            ZStack{
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 100)
                
                HStack{
                    Button("Instruction") {
                        roomVm.sheetOpening.toggle()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        roomVm.showingOption.toggle()
                    }, label: {
                        Text("Rescan")
                            .foregroundColor( roomVm.isStartScanning ? .blue : .gray)
                    })
                    .confirmationDialog("Clicking ‘Rescan’ will reset your progress and you need to start the scanning process again", isPresented: $roomVm.showingOption, titleVisibility: .visible) {
                        Button("Rescan", role: .destructive) {
                            roomVm.roomController.stopSession()
                            roomVm.isStartScanning = false
                        }
                    }
                    .disabled(!roomVm.isStartScanning)
                    
                   
                }
                .padding(.horizontal, 21)
                .padding(.top, 20)
            }
            //            MARK: camera of roomplan
            roomVm.startingScan()
            //            MARK: button start and stop session
            ZStack{
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 150)
                
                Button(action: {
                    DispatchQueue.main.async {
                        if roomVm.isStartScanning {
                            pathStore.navigateToView(.roomscanresult)
                        }
                        roomVm.buttonAction()
                    }
                }, label: {
                    Image(roomVm.isStartScanning ? .stopButtonRecord : .enableButtonRecord)
                })
                .font(.system(size: 63))
                .padding(.bottom,30)
                
            }
        }
        .sheet(isPresented: $roomVm.sheetOpening, content: {
            SheetRoomPlanView()
                .presentationDetents([.height(340)])
                .presentationCornerRadius(16)
        })
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

#Preview {
    RoomViewIteration()
}


