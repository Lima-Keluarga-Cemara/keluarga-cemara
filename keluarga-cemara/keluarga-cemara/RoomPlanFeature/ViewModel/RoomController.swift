//
//  RoomController.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import RoomPlan
import UIKit


class RoomController {
    //    MARK: Making properties
//    static var instance = RoomController()
    var roomCaptureView : RoomCaptureView
//     Try add this var
    var sessionConfig : RoomCaptureSession.Configuration = RoomCaptureSession.Configuration()
    
    init(){
        roomCaptureView = RoomCaptureView(frame: .zero)
    }
    
    //    MARK: func to start and stop scanning
    
    func startSession() {
        self.roomCaptureView.captureSession.run(configuration: sessionConfig)
    }
    
    func stopSession() {
        self.roomCaptureView.captureSession.stop()
    }

    
}
