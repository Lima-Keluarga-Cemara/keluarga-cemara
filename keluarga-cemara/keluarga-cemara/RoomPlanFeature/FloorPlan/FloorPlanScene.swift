//
//  FloorPlanScene.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 18/11/23.
//


import RoomPlan
import SceneKit

class FloorPlanScene: SCNScene {
    
    // MARK: - Properties
    
    // Surfaces and objects from our scan result
    private let surfaces: [CapturedRoom.Surface]
    private let objects: [CapturedRoom.Object]
    
    // MARK: - Init
    
    init(capturedRoom: CapturedRoom) {
        self.surfaces = capturedRoom.doors + capturedRoom.walls
        self.objects = capturedRoom.objects
        
        super.init()
        
        self.background.contents = floorPlanBackgroundColor
        
        drawSurfaces()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Draw
    
    private func drawSurfaces() {
        for surface in surfaces {
            let surfaceNode = FloorPlanSurface(capturedSurface: surface)
            rootNode.addChildNode(surfaceNode)
        }
    }
}
