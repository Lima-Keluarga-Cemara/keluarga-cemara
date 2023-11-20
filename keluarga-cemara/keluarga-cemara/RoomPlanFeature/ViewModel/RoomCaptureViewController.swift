//
//  CameraService.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 19/11/23.
//


import UIKit
import RoomPlan
import SwiftUI

class RoomCaptureViewController: UIViewController, RoomCaptureViewDelegate, RoomCaptureSessionDelegate {
  
     var roomCaptureView: RoomCaptureView!
     var roomCaptureSessionConfig: RoomCaptureSession.Configuration = RoomCaptureSession.Configuration()
    
     var finalResults: CapturedRoom?
    static var instance = RoomCaptureViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up after loading the view.
        setupRoomCaptureView()
    }
    
    private func setupRoomCaptureView() {
        roomCaptureView = RoomCaptureView(frame: view.bounds)
        roomCaptureView.captureSession.delegate = self
        roomCaptureView.delegate = self
        roomCaptureView.isModelEnabled = true
        
        view.addSubview(roomCaptureView)
//        view.insertSubview(roomCaptureView, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSession()
    }
    
    override func viewWillDisappear(_ flag: Bool) {
        super.viewWillDisappear(flag)
        stopSession()
    }
    
    func startSession() {
        roomCaptureView?.captureSession.run(configuration: roomCaptureSessionConfig)
    }
    
    func stopSession() {
        roomCaptureView?.captureSession.stop()
    }
    
    // Decide to post-process and show the final results.
    func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?) -> Bool {
        return true
    }
    
    // Access the final post-processed results.
    func captureView(didPresent processedResult: CapturedRoom, error: Error?) {
        finalResults = processedResult
        export()
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


struct RoomViewControllerRepresentable : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RoomCaptureViewController {
        return RoomCaptureViewController.instance
    }
    
    func updateUIViewController(_ uiViewController: RoomCaptureViewController, context: Context) {
        
    }
}

