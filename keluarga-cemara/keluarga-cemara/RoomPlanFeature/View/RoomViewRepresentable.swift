//
//  RoomViewRepresentable.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import SwiftUI

struct RoomViewRepresentable : UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        RoomController.instance.roomCaptureView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
