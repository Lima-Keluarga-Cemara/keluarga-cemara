//
//  MarkerNode.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 20/11/23.
//

import Foundation
import SceneKit

class MarkerNode: SCNNode{
    init(fromMatrix matrix: matrix_float4x4 ) {
        
        super.init()
        
        //1. Convert The 3rd Column Values To Float
        let x = matrix.columns.3.x
        let y = matrix.columns.3.y
        let z = matrix.columns.3.z
        
        //2. Create A Marker Node At The Detected Matrixes Position
        let markerNodeGeometry = SCNSphere(radius: 0.02)
        markerNodeGeometry.firstMaterial?.diffuse.contents = ColorResource.backgroundTile
        self.geometry = markerNodeGeometry
        self.position = SCNVector3(x, y, z)
        
    }

    required init?(coder aDecoder: NSCoder) { fatalError("Coder Not Implemented") }
}
