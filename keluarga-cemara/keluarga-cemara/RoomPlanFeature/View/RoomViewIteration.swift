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
    @State private var isFacingDirection: Bool = true
    @EnvironmentObject var pathStore: PathStore

    var body: some View {
        ZStack {
            VStack {
                HeaderView(isFacingDirection: $isFacingDirection, roomVm: roomVm)
                MainContentView(isFacingDirection: $isFacingDirection, roomVm: roomVm, locationManager: locationManager)
                FooterView(isFacingDirection: $isFacingDirection, roomVm: roomVm, pathStore: _pathStore)
            }
            .sheet(isPresented: $roomVm.sheetOpening) {
                SheetRoomPlanView()
                    .presentationDetents([.height(340)])
                    .presentationCornerRadius(16)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            isFacingDirection = true
        }
    }
}




//VIEW BAGIAN ATAS
struct HeaderView: View {
    @Binding var isFacingDirection: Bool
    @ObservedObject var roomVm: RoomViewModel

    var body: some View {
        if !isFacingDirection {
            ZStack{
                Rectangle()
                    .fill(Color(.black))
                    .frame(height: 142)
                
                HStack {
                    Button(action: {
                        roomVm.sheetOpening.toggle()
                    }) {
                        Text("Instruction")
                            .titleButton()
                    }
                    .buttonStyle(HeaderButtonStyle())
                    Spacer()
                    Button(action: {
                        roomVm.showingOption.toggle()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 25))
                            .foregroundStyle(roomVm.isStartScanning ? .white : .gray)
                    }
                    .confirmationDialog("Resetting your progress will require starting the scanning process again.", isPresented: $roomVm.showingOption, titleVisibility: .visible) {
                        Button("Rescan", role: .destructive) {
                            roomVm.roomController.stopSession()
                            roomVm.isStartScanning = false
                        }
                    }
                    .buttonStyle(HeaderButtonStyle())
                    .disabled(!roomVm.isStartScanning)
                }
                .padding(.top, 50)
                .padding(10)
            }
        } else {
            Rectangle()
                .fill(Color(.black))
                .frame(height: 142)
        }
    }
}




//KAMERA INSTRUKSI
struct MainContentView: View {
    @Binding var isFacingDirection: Bool
    @ObservedObject var roomVm: RoomViewModel
    @ObservedObject var locationManager: LocationManager

    var body: some View {
        ZStack {
            roomVm.backgroundCamera()
            if isFacingDirection {
                InstructionViewScanning(locationManager: locationManager, isFacingDirection: $isFacingDirection)
            } else {
                ButtonStartScanningInstruction(roomVm: roomVm)
            }
        }
    }
}

//VIEW BAGIAN BAWAH
struct FooterView: View {
    @Binding var isFacingDirection: Bool
    @ObservedObject var roomVm: RoomViewModel
    @EnvironmentObject var pathStore: PathStore

    var body: some View {
        if !isFacingDirection {
            ZStack {
                Rectangle()
                    .fill(Color(.black))
                    .frame(height: 179)
  
                Button(action: {
                    DispatchQueue.main.async {
                        if roomVm.isStartScanning {
                            pathStore.navigateToView(.resultfeature)
                        }
                        roomVm.buttonAction()
                    }
                }) {
                    Image(roomVm.isStartScanning ? .stopButtonRecord : .enableButtonRecord)
                }
                .padding(.bottom, 60)
            }
        } else {
            Rectangle()
                .fill(Color(.black))
                .frame(height: 179)
        }
    }
}



//KONTEN INSTRUKSI
struct InstructionViewScanning: View {
    @ObservedObject var locationManager: LocationManager
    @Binding var isFacingDirection: Bool


    var body: some View {
        VStack() {
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
    }
}

//INTRUKSI BUTTON SCAN
struct ButtonStartScanningInstruction: View {
    @ObservedObject var roomVm: RoomViewModel
    var body: some View {
        VStack {
            Spacer()
            if !roomVm.isStartScanning {
                Text("Tap button to start scanning")
                    .textInstruction()
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.gray.opacity(0.67))
                    .cornerRadius(12)
                    .padding(.bottom, 20)
            }
        }
    }
}

//STYLE BUTTON HEADER
struct HeaderButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(height: 48)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white, lineWidth: 2)
            }
    }
}


#Preview {
    RoomViewIteration()
}

