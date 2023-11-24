//
//  RoomViewModel.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 11/11/23.
//

import Foundation
import SwiftUI
import RoomPlan

class RoomViewModel : ObservableObject, RoomCaptureViewDelegate, RoomCaptureSessionDelegate {
    func encode(with coder: NSCoder) {
        fatalError("Not Needed")

    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Needed")
    }
    
    var roomController = RoomController.instance
    var cameraModel = CameraModel()
    @Published  var isStartScanning : Bool = false
    @Published  var sheetOpening : Bool = false
    @Published  var showingOption : Bool = false
    @Published  var feedbackGenerator: UIImpactFeedbackGenerator?
    
//    MARK: For Roomplan
    var finalResults : CapturedRoom?
 
    
    @ViewBuilder
    func backgroundCamera() ->  some View {
        if isStartScanning{
            
            RoomViewRepresentable()
                .onAppear{
                    self.roomController.startSession()
                }
        } else {
            CameraRepresentable(cameraModel: cameraModel)
        }
    }
    
    
    init() {
        roomController.roomCaptureView.delegate = self
        roomController.roomCaptureView.captureSession.delegate = self
    }
    
    
    func buttonAction() {
        if isStartScanning{
            print("---DEBUG--- stop scanning ")
            roomController.stopSession()
            UIApplication.shared.isIdleTimerDisabled = false
            isStartScanning = false
            feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            feedbackGenerator?.impactOccurred()
        } else {
            print("---DEBUG--- start scanning ")
//            roomController.startSession()
            UIApplication.shared.isIdleTimerDisabled = true
           isStartScanning = true
            feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator?.impactOccurred()
        }
    }
    
    func captureView(didPresent processedResult: CapturedRoom, error: (Error)?) {
        if let error = error as? RoomCaptureSession.CaptureError, error == .worldTrackingFailure {
            let alert = UIAlertController(title: "World Tracking Failure", message: "Please move your phone from top to bottom slowly to start scanning again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.isStartScanning.toggle()
                self.roomController.stopSession()
            }))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
        } else {
            finalResults = processedResult
            export()
        }
    }
    
    func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: (Error)?) -> Bool {
        return true
    }
    
    func export(){
        if let finalResults {
            let fm = FileManager.default
            var path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileName = "room.usdz"
            path.appendPathComponent(fileName)
            print("file name \(path)")
            
            do {
                try  finalResults.export(to: path.absoluteURL)
                print("Berhasil export ")
            }
            catch{
                print(error)
            }
        }
    }

}
