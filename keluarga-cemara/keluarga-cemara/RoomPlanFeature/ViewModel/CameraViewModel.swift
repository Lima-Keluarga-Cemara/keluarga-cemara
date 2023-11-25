//
//  CameraViewModel.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 10/11/23.
//

import SwiftUI
import AVFoundation

class CameraModel {
    var session : AVCaptureSession?
    var delegate : AVCapturePhotoCaptureDelegate?
    
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    func start(delegate : AVCapturePhotoCaptureDelegate, completion : @escaping (Error?) -> ()){
        self.delegate = delegate
        checkPermission(completion: completion )
    }
    
    //     let make auth
    private func checkPermission(completion : @escaping (Error?) -> ()){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {  [weak self] grandted in
                guard grandted else {return}
                
                DispatchQueue.main.async {
                    self?.setupCamera(completion: completion)
                }
            })
        case .restricted :
            break
        case .denied :
            break
        case .authorized :
            setupCamera(completion: completion)
        @unknown default :
            break
        }
    }
    
    
    private func setupCamera(completion : @escaping (Error?) -> ()) {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                
                if session.canAddOutput(output){
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                DispatchQueue.global(qos: .background).async {
                    session.startRunning()
                }
                self.session = session
            } catch {
                completion(error )
            }
        }
        
    }
}

struct CameraRepresentable : UIViewControllerRepresentable{
    typealias UIViewControllerType = UIViewController
    let cameraModel : CameraModel
    
    func makeUIViewController(context: Context) -> UIViewController {
        cameraModel.start(delegate: context.coordinator) { error in
            if let error = error {
                print(error.localizedDescription )
            }
        }
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
        viewController.view.layer.addSublayer(cameraModel.previewLayer)
        cameraModel.previewLayer.frame = viewController.view.bounds.standardized
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator : NSObject, AVCapturePhotoCaptureDelegate{
        let parent : CameraRepresentable
        init(_ parent: CameraRepresentable) {
            self.parent = parent
        }
    }
    
}
