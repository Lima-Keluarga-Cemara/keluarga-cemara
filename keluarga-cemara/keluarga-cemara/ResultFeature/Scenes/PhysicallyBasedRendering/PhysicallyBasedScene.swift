import Foundation
import SceneKit
import SceneKit.ModelIO
import GLKit
import SwiftUI

class LightPosition: ObservableObject {
    @Published var x: Float = 0.0
    @Published var y: Float = 0.0
    @Published var z: Float = 0.0
    @Published var orientation_x: Float = -20.93
    @Published var orientation_y: Float = -53.33
}



@objc class PhysicallyBasedScene: SCNScene, Scenee {
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
 
    
    private func createCamera() {
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
//        createPhysicallyLightingEnviroment()
    }
   
    private func createPhysicallyBasedLight() -> PhysicallyBasedLight {
        let lightFeatures = LightFeatures(
            position: SCNVector3Make(lightPosition.x, lightPosition.y, lightPosition.z),
            orientation: SCNVector3Make(lightPosition.orientation_x, lightPosition.orientation_y, 0),
//             try to change this color
            color: UIColor.red
        )
        
        let physicallyBasedLightFeatures = PhysicallyBasedLightFeatures(lumen: 100, temperature: 4000)
        
        return PhysicallyBasedLight(
            lightFeatures: lightFeatures,
            physicallyBasedLightFeatures: physicallyBasedLightFeatures
        )
    }

    
//    
//    private func createPhysicallyLightingEnviroment() {
//        let enviroment = PhysicallyBasedLightingEnviroment(
//            cubeMap: ["rightPBR.png", "leftPBR.png", "upPBR.png", "downPBR.png", "backPBR.png", "frontPBR.png"],
//            intensity: 1.0
//        )
//        enviroment.setLightingEnviromentFor(scene: self)
//    }
    
    private func createObjects() {
        addFloor()
        addRoom()
    }
    
    
    private func addFloor() {
        let floor = PhysicallyBasedObject(
            mesh: MeshLoader.loadMeshWith(name: "Floor", ofType: "obj"),
            material: PhysicallyBasedMaterial(
                diffuse: "floor-diffuse.png",
                roughness: NSNumber(value: 0.8),
                metalness: "floor-metalness.png",
                normal: "floor-normal.png",
                ambientOcclusion: "floor-ambient-occlusion.png"
            ),
            position: SCNVector3Make(0, -1.8, 0),
            rotation: SCNVector4Make(0, 0, 0, 0)
        )
        rootNode.addChildNode(floor.node)
    }
    
    
    private func addRoom() {
        let room = PhysicallyBasedObject(
            mesh: MeshLoader.loadMeshWith(name: "room", ofType: "usdz"),
            material: PhysicallyBasedMaterial(
                diffuse: "cement-diffuse.png",
                roughness: NSNumber(value: 0.1),
                metalness: "cement-metalness.png",
                normal: "cement-normal.png",
                ambientOcclusion: "cement-ambient-occlusion.png"
            ),
            position: SCNVector3Make(0, 0, 0),
            rotation: SCNVector4Make(0, 0, 0, 0)
        )
        rootNode.addChildNode(room.node)
    }
    
}

