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
    
    var body: some View {
        ZStack{
            VStack{
//                MARK: Header
                if !isFacingDirection {
                    ZStack{
                        Rectangle()
                            .frame(height: 142)
                        
                        HStack{
                            
                            Button(action: {
                                roomVm.sheetOpening.toggle()
                            }, label: {
                                Text("Instruction")
                                    .titleButton()
                            })
                            .padding()
                            .frame(height: 48)
                            .cornerRadius(12)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 2)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                roomVm.showingOption.toggle()
                            }, label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 25))
                                    .foregroundStyle(roomVm.isStartScanning ? .white : .gray)
                            })
                            .confirmationDialog("Clicking ‘Rescan’ will reset your progress and you need to start the scanning process again", isPresented: $roomVm.showingOption, titleVisibility: .visible) {
                                Button("Rescan", role: .destructive) {
                                    roomVm.roomController.stopSession()
                                    roomVm.isStartScanning = false
                                }
                            }
                            .padding()
                            .frame(width: 52, height: 48)
                            .cornerRadius(12)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(roomVm.isStartScanning ? .white : .gray, lineWidth: 2)
                            })
                            .disabled(!roomVm.isStartScanning)
                            
                            
                        }
                        .padding(.top,50)
                        .padding(.horizontal,35)
                    }
                } else {
                    Rectangle()
                        .frame(height: 142)
                }
                
                ZStack{
                    roomVm.backgroundCamera()


                    if isFacingDirection {
                        VStack{
                            
                            Spacer()
                            
                            LottieView(loopMode: .loop, resource: "instruksi-opening.json")
                                .frame(width: 100, height: 100)
                                .padding(.bottom, 32)
                            
                            Text("Bring phone to garden area and face \nit to the side where sunlight comes in")
                                .textInstruction()
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 24)
                            
                            ButtonCustom(title: "Next", action: {
                                isFacingDirection.toggle()
                                locationManager.resultOrientationDirection = locationManager.orientationGarden
                            }, width: 116, height: 44)
                            
                            Spacer()
                        }
                    } else {
                        VStack{
                            Spacer()
                            if !roomVm.isStartScanning {
                                Text("Tap button to start scanning")
                                    .textInstruction()
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color.gray.opacity(0.67))
                                    .cornerRadius(12)
                                    .padding(.bottom,20)
                            }
                        }
                       
                    }
                }
                
//                MARK: footer
                if !isFacingDirection {
                    ZStack{
                        Rectangle()
                            .frame(height: 179)
                        
                        Button(action: {
                            DispatchQueue.main.async {
                                if roomVm.isStartScanning {
                                    pathStore.navigateToView(.resultfeature)
                                }
                                roomVm.buttonAction()
                            }
                        }, label: {
                            Image(roomVm.isStartScanning ? .stopButtonRecord : .enableButtonRecord)
                        })
                        .padding(.bottom, 60)
                    }
                } else {
                    Rectangle()
                        .frame(height: 179)
                }
            }
            .sheet(isPresented: $roomVm.sheetOpening, content: {
                SheetRoomPlanView()
                    .presentationDetents([.height(340)])
                    .presentationCornerRadius(16)
            })
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RoomViewIteration()
}


