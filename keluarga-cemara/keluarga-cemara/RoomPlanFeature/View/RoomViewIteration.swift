//
//  RoomViewIteration.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 27/10/23.
//

import SwiftUI

struct RoomViewIteration: View {
    @StateObject private var roomVm = RoomViewModel()
    @StateObject var locationManager = LocationManager()
    @State private  var isFacingDirection : Bool = true

    @EnvironmentObject  var pathStore: PathStore
    
    @ViewBuilder
    func detectOpening() -> some View{
       if  isFacingDirection {
           ZStack{
               CameraRepresentable(cameraModel: roomVm.cameraModel)
                   .ignoresSafeArea()
               
               VStack{
                   Text("Facing \(locationManager.direction) side")
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
       } else {
           roomVm.startingScan()
       }
    }
    

    var body: some View {
        VStack(spacing : 0){
            //            MARK: Navbar instruction nd exit
            ZStack{
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 100)
                
                HStack{
                    if isFacingDirection{
                        EmptyView()
                    } else {
                        Button("Instruction") {
                            roomVm.sheetOpening.toggle()
                        }
                    }
                    
                    Spacer()
                    
                    if isFacingDirection{
                        Button("Next") {
                            isFacingDirection.toggle()
                        }
                    } else {
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
                    
                   
                }
                .padding(.horizontal, 21)
                .padding(.top, 20)
            }
            //            MARK: camera of roomplan
           detectOpening()
            //            MARK: button start and stop session
            ZStack{
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 150)
                
                Button(action: {
                    DispatchQueue.main.async {
                        if roomVm.isStartScanning {
                            pathStore.navigateToView(.resultfeature)
                        }
                        roomVm.buttonAction()
                    }
                }, label: {
                    if isFacingDirection{
                        Image(.disableButtonRecord)
                    } else {
                        Image(roomVm.isStartScanning ? .stopButtonRecord : .enableButtonRecord)
                    }
                   
                })
                .font(.system(size: 63))
                .padding(.bottom,30)
                .disabled(isFacingDirection)

                
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


