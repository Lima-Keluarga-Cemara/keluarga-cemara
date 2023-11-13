
import SceneKit.ModelIO

//class MeshLoader {
//    static func loadMeshWith(name: String, ofType type: String) -> MDLObject {
//        let path = Bundle.main.path(forResource: name, ofType: type)!
//        let asset = MDLAsset(url: URL(fileURLWithPath: path))
//        return asset[0]!
//    }
//}
//import SceneKit.ModelIO


class MeshLoader {
    static func loadMeshWith(filePath: String) -> MDLObject? {
        let fileURL = URL(string: filePath)!
        do {
            let asset = try MDLAsset(url: fileURL)
            return asset.object(at: 0)
        } catch {
            print("Error loading mesh: \(error)")
            return nil
        }
        
    }
    
    func fileName() -> String {
        let fm = FileManager.default
        let path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filename = "room.usdz"
        let modelFilePath = path.appendingPathComponent(filename).absoluteString
        return modelFilePath
    }
}
