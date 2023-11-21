import Foundation
import SceneKit
import SceneKit.ModelIO
import GLKit
import SwiftUI

class LightPosition: ObservableObject {
    var x: Float = 0.0
    var y: Float = 0.0
    var z: Float = 0.0
    
    @Published var orientation_x: [Float] = [-0.1, -0.19, -0.33, -0.53, -0.84, -0.60, -0.59]
    @Published var orientation_y: [Float] = [0.3, 0.60, 0.64, 0.67, -0.40, -0.18, -0.65]
    @Published var orientation_z: [Float] = [0.94, 0.83, 0.68, 0.50, -0.35, -56.10, -0.46]
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
        createLight1()
        createLight2()
        createLight3()
        createLight4()
        createLight5()
        createLight6()
        
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
//        createPhysicallyLightingEnviroment()
    }
    
    func createLight1() {
        rootNode.addChildNode(createPhysicallyBasedLight1().node)
//        createPhysicallyLightingEnviroment()
    }
    
    func createLight2() {
        rootNode.addChildNode(createPhysicallyBasedLight2().node)
//        createPhysicallyLightingEnviroment()
    }
    
    func createLight3() {
        rootNode.addChildNode(createPhysicallyBasedLight3().node)
//        createPhysicallyLightingEnviroment()
    }
    func createLight4() {
        rootNode.addChildNode(createPhysicallyBasedLight4().node)
//        createPhysicallyLightingEnviroment()
    }
    
    func createLight5() {
        rootNode.addChildNode(createPhysicallyBasedLight5().node)
//        createPhysicallyLightingEnviroment()
    }
    
    func createLight6() {
        rootNode.addChildNode(createPhysicallyBasedLight6().node)
//        createPhysicallyLightingEnviroment()
    }
    
    private func createPhysicallyBasedLight() -> PhysicallyBasedLight {
        let lightFeatures = LightFeatures(
            position: SCNVector3Make(lightPosition.x, lightPosition.y, lightPosition.z),
            orientation: SCNVector3Make(lightPosition.orientation_x[0], lightPosition.orientation_y[0], lightPosition.orientation_z[0]),
            color: UIColor.white
        )
        
        let physicallyBasedLightFeatures = PhysicallyBasedLightFeatures(lumen: 400, temperature: 4000)
        
        return PhysicallyBasedLight(
            lightFeatures: lightFeatures,
            physicallyBasedLightFeatures: physicallyBasedLightFeatures
        )
    }
    
    private func createPhysicallyBasedLight1() -> PhysicallyBasedLight {
        let lightFeatures = LightFeatures(
            position: SCNVector3Make(lightPosition.x, lightPosition.y, lightPosition.z),
            orientation: SCNVector3Make(lightPosition.orientation_x[1], lightPosition.orientation_y[1], lightPosition.orientation_z[1]),
            color: UIColor.white
        )
        
        let physicallyBasedLightFeatures = PhysicallyBasedLightFeatures(lumen: 200, temperature: 4000)
        
        return PhysicallyBasedLight(
            lightFeatures: lightFeatures,
            physicallyBasedLightFeatures: physicallyBasedLightFeatures
        )
    }
    
    private func createPhysicallyBasedLight2() -> PhysicallyBasedLight {
        let lightFeatures = LightFeatures(
            position: SCNVector3Make(lightPosition.x, lightPosition.y, lightPosition.z),
            orientation: SCNVector3Make(lightPosition.orientation_x[2], lightPosition.orientation_y[2], lightPosition.orientation_z[2]),
            color: UIColor.white
        )
        
        let physicallyBasedLightFeatures = PhysicallyBasedLightFeatures(lumen: 200, temperature: 4000)
        
        return PhysicallyBasedLight(
            lightFeatures: lightFeatures,
            physicallyBasedLightFeatures: physicallyBasedLightFeatures
        )
    }
    
    private func createPhysicallyBasedLight3() -> PhysicallyBasedLight {
        let lightFeatures = LightFeatures(
            position: SCNVector3Make(lightPosition.x, lightPosition.y, lightPosition.z),
            orientation: SCNVector3Make(lightPosition.orientation_x[3], lightPosition.orientation_y[3], lightPosition.orientation_z[3]),
            color: UIColor.white
        )
        
        let physicallyBasedLightFeatures = PhysicallyBasedLightFeatures(lumen: 200, temperature: 4000)
        
        return PhysicallyBasedLight(
            lightFeatures: lightFeatures,
            physicallyBasedLightFeatures: physicallyBasedLightFeatures
        )
    }
    
    private func createPhysicallyBasedLight4() -> PhysicallyBasedLight {
        let lightFeatures = LightFeatures(
            position: SCNVector3Make(lightPosition.x, lightPosition.y, lightPosition.z),
            orientation: SCNVector3Make(lightPosition.orientation_x[4], lightPosition.orientation_y[4], lightPosition.orientation_z[4]),
            color: UIColor.white
        )
        
        let physicallyBasedLightFeatures = PhysicallyBasedLightFeatures(lumen: 400, temperature: 4000)
        
        return PhysicallyBasedLight(
            lightFeatures: lightFeatures,
            physicallyBasedLightFeatures: physicallyBasedLightFeatures
        )
    }
    
    private func createPhysicallyBasedLight5() -> PhysicallyBasedLight {
        let lightFeatures = LightFeatures(
            position: SCNVector3Make(lightPosition.x, lightPosition.y, lightPosition.z),
            orientation: SCNVector3Make(lightPosition.orientation_x[5], lightPosition.orientation_y[5], lightPosition.orientation_z[5]),
            color: UIColor.white
        )
        
        let physicallyBasedLightFeatures = PhysicallyBasedLightFeatures(lumen: 400, temperature: 4000)
        
        return PhysicallyBasedLight(
            lightFeatures: lightFeatures,
            physicallyBasedLightFeatures: physicallyBasedLightFeatures
        )
    }
    
    private func createPhysicallyBasedLight6() -> PhysicallyBasedLight {
        let lightFeatures = LightFeatures(
            position: SCNVector3Make(lightPosition.x, lightPosition.y, lightPosition.z),
            orientation: SCNVector3Make(lightPosition.orientation_x[6], lightPosition.orientation_y[6], lightPosition.orientation_z[6]),
            color: UIColor.white
        )
        
        let physicallyBasedLightFeatures = PhysicallyBasedLightFeatures(lumen: 400, temperature: 4000)
        
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
    
    
//    private func addFloor() {
//        let floor = PhysicallyBasedObject(
//            mesh: MeshLoader.loadMeshWith(name: "Floor", ofType: "obj"),
//            material: PhysicallyBasedMaterial(
//                diffuse: "bg_orange.png",
//                roughness: NSNumber(value: 0.8),
//                metalness: "floor-metalness.png",
//                normal: "bg_orange.png",
//                ambientOcclusion: "floor-ambient-occlusion.png"
//            ),
//            position: SCNVector3Make(0, -1, 0),
//            rotation: SCNVector4Make(0, 0, 0, 0)
//        )
//        rootNode.addChildNode(floor.node)
//    }
    
    
    
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


