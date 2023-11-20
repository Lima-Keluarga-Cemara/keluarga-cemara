//
//  SCNVector3+RotateAround.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 18/11/23.
//

import SceneKit

extension SCNVector3 {
    
    func rotateAround(axis: SCNVector3, by angle: SCNFloat) -> SCNVector3 {
        let rotationMatrix = SCNMatrix4MakeRotation(angle, axis.x, axis.y, axis.z)
        let rotatedVector = SCNMatrix4Mult(rotationMatrix, SCNMatrix4MakeTranslation(x, y, z))
        
        return SCNVector3(rotatedVector.m41, rotatedVector.m42, rotatedVector.m43)
    }
    
}
