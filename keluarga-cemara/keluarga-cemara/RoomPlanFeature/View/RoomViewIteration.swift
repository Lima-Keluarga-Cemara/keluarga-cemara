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
    @StateObject private var locationManager = LocationManager()
    @State private var isStartScanning : Bool = false
    @State private var sheetOpening : Bool = true
    @State private var showingOption : Bool = false
    @State private var feedbackGenerator: UIImpactFeedbackGenerator?
    
    var body: some View {
        VStack(spacing : 0){
            //            MARK: Navbar instruction nd exit
            ZStack{
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 100)
                
                HStack{
                    Button("Instruction") {
                        sheetOpening.toggle()
                    }
                    
                    Spacer()
                    
                    Button("Exit") {
                        showingOption.toggle()
                    }
                    .confirmationDialog("These scanned area will be gone and you can start scanning again from the beginning", isPresented: $showingOption, titleVisibility: .visible) {
                        Button("Exit", role: .destructive) {
                            isStartScanning = false
                            roomController.stopSession()
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
            }
            //            MARK: camera of roomplan
            if isStartScanning{
                RoomViewRepresentable()
            } else {
                ZStack{
                    Color(.blackCamera)
                }
            }
               
            //            MARK: button start and stop session
            ZStack{
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 150)
                
                Button(action: {
                    if isStartScanning{
                        isStartScanning = false
                        roomController.stopSession()
                        pathStore.navigateToView(.roomscanresult)
                        feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                        feedbackGenerator?.impactOccurred()
                        locationManager.resultOrientationDirection = locationManager.orientationGarden
                    } else {
                        isStartScanning = true
                        roomController.startSession()
                        feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
                        feedbackGenerator?.impactOccurred()
                    }
                }, label: {
                    Image(systemName: isStartScanning ? "stop.circle" : "circle.inset.filled")
                        .foregroundColor( isStartScanning ? .red : .white )
                        .font(.system(size: 64))
                })
                
            }
        }
        .sheet(isPresented: $sheetOpening, content: {
            SheetRoomPlanView()
                .presentationDetents([.height(350)])
                .presentationCornerRadius(16)
        })
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
    
}

#Preview {
    RoomViewIteration()
}


