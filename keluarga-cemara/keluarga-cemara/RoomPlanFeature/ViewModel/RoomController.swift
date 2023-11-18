//
//  RoomController.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import RoomPlan
import SceneKit
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
    var sessionConfig : RoomCaptureSession.Configuration
    var finalResults : CapturedRoom?
    
    var sceneView : SCNView?
    
    init(){
        roomCaptureView = RoomCaptureView(frame: .zero)
        sessionConfig = RoomCaptureSession.Configuration()
        roomCaptureView.captureSession.delegate = self
        roomCaptureView.delegate = self
    }
    
    //    MARK: func to start and stop scanning
    
    func startSession() {
        roomCaptureView.captureSession.run(configuration: sessionConfig)
        UIApplication.shared.isIdleTimerDisabled = true
        
    }
    
    func stopSession() {
        roomCaptureView.captureSession.stop()
        UIApplication.shared.isIdleTimerDisabled = false
        
    }
    
    
    //    MARK: func captureview (post-processing scan result)
    
    func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: (Error)?) -> Bool {
        return true
    }
    
    func captureView(didPresent processedResult: CapturedRoom, error: (Error)?) {
        if let error = error as? RoomCaptureSession.CaptureError, error == .worldTrackingFailure {
            let alert = UIAlertController(title: "World Tracking Failure", message: "An unexpected error occurred during world tracking.Please click re-scan to start scan again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
        guard error == nil else {
            print("Error when capturing room: \(error!.localizedDescription)")
            return
        }
        Task{
            finalResults = processedResult
            export()
        }
        
    }
    
    //    MARK: func for export file
    
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
    
    
    
    //    MARK: func for scenekit detect dimension of surface
    func getAllNodes(for surfaces : [CapturedRoom.Surface], contents : Any?) -> [SCNNode] {
        var nodes : [SCNNode] = []
        
        surfaces.forEach { surface in
            let width = CGFloat(surface.dimensions.x)
            let height = CGFloat(surface.dimensions.y)
            let depth = CGFloat(surface.dimensions.z)
            
            print("Surface with category \(surface.category), have a width \(width), height \(height), and depth \(depth)")
            
            let node = SCNNode()
            node.geometry = SCNBox(width: width, height: height, length: depth, chamferRadius: 0.0)
            node.geometry?.firstMaterial?.diffuse.contents = contents
            node.transform = SCNMatrix4(surface.transform)
            nodes.append(node)
        }
        
        return nodes
    }
    
    
    
    func onModelReady(model : CapturedRoom) {
        let walls = getAllNodes(for: model.walls , contents:  UIColor.red)
        walls.forEach { sceneView?.scene?.rootNode.addChildNode($0)}
        
        let doors = getAllNodes(for: model.doors , contents:  UIColor.blue)
        doors.forEach { sceneView?.scene?.rootNode.addChildNode($0)}
        
        let windows = getAllNodes(for: model.windows , contents:  UIColor.gray)
        windows.forEach { sceneView?.scene?.rootNode.addChildNode($0)}
        
        let openings = getAllNodes(for: model.openings , contents:  UIColor.green)
        openings.forEach { sceneView?.scene?.rootNode.addChildNode($0)}
        
        if #available(iOS 17.0, *) {
            let floors = getAllNodes(for: model.floors , contents:  UIColor.blue.withAlphaComponent(0.6))
            floors.forEach { sceneView?.scene?.rootNode.addChildNode($0)}
        } else {
            // Fallback on earlier versions
        }
        
        //         looping for object
        for object in model.objects {
            let uuidString = object.identifier.uuidString
            let category = object.category
            let dimesion = object.dimensions
            
            print("Object with id \(uuidString) with category \(category), with width \(dimesion.x), height \(dimesion.y) and depth \(dimesion.z)")
        }
    }
    
    
}
