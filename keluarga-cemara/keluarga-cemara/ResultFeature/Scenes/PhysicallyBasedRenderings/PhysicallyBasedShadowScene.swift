//
//  PhysicallyBasedShadowScene.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 20/11/23.
//

import Foundation
import SceneKit
import SceneKit.ModelIO
import GLKit
import SwiftUI

@objc class PhysicallyBasedShadowScene: SCNScene, Scenee {
    var camera: Camera!
    var lightPosition : LightPosition
    var physicallyBasedLight: PhysicallyBasedLight?
    var lightFeatures: LightFeatures!
    
    init(lightPosition : LightPosition) {
        self.lightPosition = lightPosition
        super.init()
        createCamera()
        createLight()
    
        createObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     func createCamera() {
        camera = Camera(
            position: SCNVector3Make(0, 10, 0),
            rotation: SCNVector4Make(1, 0, 0, GLKMathDegreesToRadians(-90)),
            wantsHDR: true,
            pivot: SCNMatrix4MakeTranslation(0, 0, 0)
        )
        rootNode.addChildNode(camera.node)
    }
    
    func createLight() {
        rootNode.addChildNode(createPhysicallyBasedLight().node)
    }
    

    private func createPhysicallyBasedLight() -> PhysicallyBasedLight {
        let lightFeatures = LightFeatures(
            position: SCNVector3Make(lightPosition.x, lightPosition.y, lightPosition.z),
            orientation: SCNVector3Make(lightPosition.orientation_x[0], lightPosition.orientation_y[0], lightPosition.orientation_z[0]),
            color: UIColor.white
        )
        
        let physicallyBasedLightFeatures = PhysicallyBasedLightFeatures(lumen: 200, temperature: 4000)
        
        return PhysicallyBasedLight(
            lightFeatures: lightFeatures,
            physicallyBasedLightFeatures: physicallyBasedLightFeatures
        )
    }
  
    
    private func createPhysicallyLightingEnviroment() {
        let enviroment = PhysicallyBasedLightingEnviroment(
            cubeMap: ["bg_orange.png", "bg_orange.png", "bg_orange.png", "bg_orange.png", "bg_orange.png", "bg_orange.png"],
            intensity: 5.0
        )
        enviroment.setLightingEnviromentFor(scene: self)
    }
    
    
    
    private func createObjects() {
//        addFloor()
        addRoom(rotation: SCNVector4Make(0, 5, 0, 45))
    }
    

    
    private func addRoom(rotation: SCNVector4) {
        DispatchQueue.main.async {
            do {
                let meshLoader = MeshLoader()
                
                if let meshObject = MeshLoader.loadMeshWith(filePath: meshLoader.fileName()) {
                    let room = PhysicallyBasedObject(
                        mesh: meshObject,
                        material: PhysicallyBasedMaterial(
                            diffuse: "cement-diffuse.png",
                            roughness: NSNumber(value: 0.1),
                            metalness: "cement-metalness.png",
                            normal: "cement-normal.png",
                            ambientOcclusion: "cement-ambient-occlusion.png"
                        ),
                        position: SCNVector3Make(0, 0, 0),
                        rotation: rotation
                    )
                    self.rootNode.addChildNode(room.node)
                    self.rootNode.name = "room"
                } else {
                    print("Failed to load mesh.")
                }
            }
        }
        
    }
}
