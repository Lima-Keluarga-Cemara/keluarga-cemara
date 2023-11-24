//
//  RoomController.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import RoomPlan
import UIKit


class RoomController : ObservableObject,RoomCaptureViewDelegate, RoomCaptureSessionDelegate{
    func encode(with coder: NSCoder) {
        fatalError("Not Needed")
    }
    
    
    required dynamic init?(coder: NSCoder) {
        fatalError("Not Needed")
    }
    
    
    //    MARK: Making properties
    static var instance = RoomController()
    @Published var roomCaptureView : RoomCaptureView
//     Try add this var
    @Published var isStartScanning : Bool = false
    var sessionConfig : RoomCaptureSession.Configuration = RoomCaptureSession.Configuration()
    var finalResults : CapturedRoom?
    
    init(){
        roomCaptureView = RoomCaptureView(frame: .zero)
    }
    
    //    MARK: func to start and stop scanning
    
    func startSession() {
        roomCaptureView.captureSession.run(configuration: sessionConfig)
        
    }
    
    func stopSession() {
        roomCaptureView.captureSession.stop()
        
    }

    
}
