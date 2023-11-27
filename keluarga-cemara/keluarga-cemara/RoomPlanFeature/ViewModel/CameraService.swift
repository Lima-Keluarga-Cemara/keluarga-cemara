//
//  CameraService.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 26/11/23.
//

import AVFoundation
import SwiftUI

class CameraService {
    var session = AVCaptureSession()
    var preview : AVCaptureVideoPreviewLayer!
    
    func check(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized :
            setUp()
            return
        case .notDetermined :
            //            restart with for permission
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status{
                    self.setUp()
                }
            }
        case .denied:
            return
        default :
            return
        }
    }
    
    func setUp() {
        //        setting up camera
        do {
            self.session.beginConfiguration()
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            let input = try AVCaptureDeviceInput(device: device!)
            //            checking to add the sessin
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            
            //            MARK: dont useing output
            self.session.commitConfiguration()
        } catch{
            print(error.localizedDescription)
        }
    }
}



struct CameraViewRepresentable : UIViewRepresentable {
    var camera : CameraService
    
    func makeUIView(context: Context) ->  UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
