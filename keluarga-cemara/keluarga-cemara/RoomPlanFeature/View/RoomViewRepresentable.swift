//
//  RoomViewRepresentable.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import SwiftUI
import RoomPlan

struct RoomViewRepresentable : UIViewRepresentable {
    func makeUIView(context: Context) -> RoomCaptureView {
        return RoomController.instance.roomCaptureView
    }
    
    func updateUIView(_ uiView: RoomCaptureView, context: Context) {
        
    }
}
