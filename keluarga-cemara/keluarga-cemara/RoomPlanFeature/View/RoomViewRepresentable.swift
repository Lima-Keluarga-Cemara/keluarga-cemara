//
//  RoomViewRepresentable.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import SwiftUI
import RoomPlan

struct RoomViewRepresentable : UIViewRepresentable {
    var roomController: RoomController
    func makeUIView(context: Context) -> RoomCaptureView {
        return roomController.roomCaptureView
    }
    
    func updateUIView(_ uiView: RoomCaptureView, context: Context) {
        
    }
}
