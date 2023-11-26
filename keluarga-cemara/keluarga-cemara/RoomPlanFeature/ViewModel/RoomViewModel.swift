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
    var cameraModel = CameraService()

    @Published  var isStartScanning : Bool = false
    @Published  var sheetOpening : Bool = false
    @Published  var showingOption : Bool = false
    @Published  var feedbackGenerator: UIImpactFeedbackGenerator?
    
//    MARK: For Roomplan
    var finalResults : CapturedRoom?
 
    
//    @ViewBuilder
//    func backgroundCamera() ->  some View {
//        if isStartScanning{
//            RoomViewRepresentable()
//                .onAppear{
//                    self.roomController.startSession()
//                    print("---DEBUG--- Camera RoomPlan Active")
//                }
//                .onDisappear {
//                    self.roomController.stopSession()
//                    print("---DEBUG--- Camera RoomPlan Deactive")
//
//                }
//        } else {
//            CameraViewRepresentable(camera: cameraModel)
//                .onAppear(perform: {
//                    DispatchQueue.global(qos: .background).async {
//                        self.cameraModel.check()
//                        self.cameraModel.session.startRunning()
//                        print("Camera ONAPPEAR")
//
//                    }
//                })
//                .onDisappear(perform: {
//                    self.cameraModel.session.stopRunning()
//                    print("Camera ONDISSAPEAR")
//                })
//        }
//    }
    
    @ViewBuilder
    func backgroundCamera() -> some View {
        switch isStartScanning {
        case true:
            RoomViewRepresentable()
                .onAppear {
                    self.roomController.startSession()
                    print("---DEBUG--- Camera RoomPlan Active")
                }
                .onDisappear {
                    self.roomController.stopSession()
                    print("---DEBUG--- Camera RoomPlan Deactive")
                }
        case false:
            CameraViewRepresentable(camera: cameraModel)
                .onAppear(perform: {
                    DispatchQueue.global(qos: .background).async {
                        self.cameraModel.check()
                        self.cameraModel.session.startRunning()
                        print("Camera ONAPPEAR")
                    }
                })
                .onDisappear(perform: {
                    self.cameraModel.session.stopRunning()
                    print("Camera ONDISSAPEAR")
                })
        }
    }
    
    
    init() {
        roomController.roomCaptureView.delegate = self
        roomController.roomCaptureView.captureSession.delegate = self
    }
    
    
//    func buttonAction() {
//        if isStartScanning{
//            print("---DEBUG--- stop scanning ")
////            roomController.stopSession()
//            UIApplication.shared.isIdleTimerDisabled = false
//            isStartScanning = false
//            feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
//            feedbackGenerator?.impactOccurred()
//        } else {
//            print("---DEBUG--- start scanning ")
////            roomController.startSession()
//            UIApplication.shared.isIdleTimerDisabled = true
//            isStartScanning = true
//            feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
//            feedbackGenerator?.impactOccurred()
//        }
//    }
    
    func captureView(didPresent processedResult: CapturedRoom, error: (Error)?) {
        Task{
            finalResults = processedResult
            export()
        }
        
        if let error = error as? RoomCaptureSession.CaptureError, error == .worldTrackingFailure {
            let alert = UIAlertController(title: "World Tracking Failure", message: "Try moving your phone slowly from top to bottom to start scanning again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
//                self.roomController.stopSession()
                print("DEBUG Stop Session Error")
                self.isStartScanning = false
            }))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
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
