
import SceneKit

class PhysicallyBasedLightingEnviroment {
    let cubeMap: [String]
    let intensity: CGFloat
    init(cubeMap: [String], intensity: CGFloat) {
        self.cubeMap = cubeMap
        self.intensity = intensity
    }
    
    func setLightingEnviromentFor(scene: SCNScene) {
        scene.lightingEnvironment.contents = cubeMap
        scene.lightingEnvironment.intensity = intensity
        scene.background.contents = cubeMap
        scene.lightingEnvironment.contents = nil
    }
}
