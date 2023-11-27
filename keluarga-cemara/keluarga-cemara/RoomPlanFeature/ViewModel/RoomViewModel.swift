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
    
    var rc = RoomController()
    var cs = CameraService()
    
    @Published  var isStartScanning : Bool = false
    @Published  var sheetOpening : Bool = false
    @Published  var showingOption : Bool = false
    @Published  var feedbackGenerator: UIImpactFeedbackGenerator?
    
    //    MARK: For Roomplan
    var finalResults : CapturedRoom?
    
    @ViewBuilder
    func backgroundCamera() -> some View {
        switch isStartScanning {
        case true:
            RoomViewRepresentable(roomController: rc)
                .onAppear {
                    self.rc.startSession()
                    print("---DEBUG--- Camera RoomPlan Active")
                }
                .onDisappear {
                    self.rc.stopSession()
                    print("---DEBUG--- Camera RoomPlan Deactive")
                }
        case false:
            CameraViewRepresentable(camera: cs)
                .onAppear(perform: {
                    DispatchQueue.global(qos: .background).async {
                        self.cs.check()
                        self.cs.session.startRunning()
                        print("---DEBUG--- Camera ONAPPEAR")
                    }
                })
                .onDisappear{
                    self.cs.session.stopRunning()
                    print("---DEBUG--- Camera ONDISSAPEAR")
                }
        }
    }
    
    
    init() {
        print("---DEBUG--- RoomViewModel Init")
        rc.roomCaptureView.delegate = self
        rc.roomCaptureView.captureSession.delegate = self
    }
    
    func captureView(didPresent processedResult: CapturedRoom, error: (Error)?) {
        if let error = error as? RoomCaptureSession.CaptureError, error == .worldTrackingFailure {
            let alert = UIAlertController(title: "World Tracking Failure", message: "Try moving your phone slowly from top to bottom to start scanning again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                print("DEBUG Stop Session Error")
//                self.rc.stopSession()
                self.rc.roomCaptureView = RoomCaptureView(frame: .zero)
                self.rc.roomCaptureView.delegate = self
                self.rc.roomCaptureView.captureSession.delegate = self
                self.isStartScanning = false
            }))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
        Task{
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
