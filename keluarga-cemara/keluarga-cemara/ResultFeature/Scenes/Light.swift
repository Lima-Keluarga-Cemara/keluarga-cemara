
import SceneKit

class Light {
    let node: SCNNode
    
    init(lightNode: SCNNode) {
        node = lightNode
    }
    
    init(lightFeatures: LightFeatures) {
        node = SCNNode()
        createLight()
        createLight1()
        set(lightFeatures: lightFeatures)
    }
    
    func createLight() {
        node.light = SCNLight()
        
    }
    
    func createLight1() {
        node.light = SCNLight()
        
    }
    
    func createLight2() {
        node.light = SCNLight()
        
    }
    
    func createLight3() {
        node.light = SCNLight()
        
    }
    
    func createLight4() {
        node.light = SCNLight()
        
    }
    
    func createLight5() {
        node.light = SCNLight()
        
    }
    
    private func set(lightFeatures: LightFeatures) {
        node.light?.color = lightFeatures.color
        node.position = lightFeatures.position
        node.name = "Light"
        node.eulerAngles = lightFeatures.orientation;
        
    }
}
