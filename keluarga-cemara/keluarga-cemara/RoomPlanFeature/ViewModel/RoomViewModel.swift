//
//  RoomViewModel.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 11/11/23.
//

import Foundation
import SwiftUI

class RoomViewModel : ObservableObject{
     var roomController = RoomController.instance
     var cameraModel = CameraModel()
    @Published  var isStartScanning : Bool = false
    @Published  var sheetOpening : Bool = false
    @Published  var showingOption : Bool = false
    @Published  var feedbackGenerator: UIImpactFeedbackGenerator?
    
    @ViewBuilder
    func startingScan() -> some View {
        if isStartScanning{
            RoomViewRepresentable()
        } else {
            ZStack{
                CameraRepresentable(cameraModel: cameraModel)
                VStack{
                    Spacer()
                    Text("Tap ‘Record button’ to start scanning")
                        .textInstruction()
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color(.black).opacity(0.7))
                        .cornerRadius(12)
                        .padding(.bottom,27)
                }
            }
        }
    }
    
   
    
    func buttonAction() {
        if isStartScanning{
            roomController.stopSession()
            isStartScanning = false
            feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            feedbackGenerator?.impactOccurred()
        } else {
            roomController.startSession()
            isStartScanning = true
            feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator?.impactOccurred()
        }
    }
    
}
