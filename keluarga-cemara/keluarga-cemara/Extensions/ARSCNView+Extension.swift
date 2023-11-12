//
//  ARSCNView+Extension.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 11/11/23.
//

import ARKit

extension ARSCNView{
    func addCoaching(){
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = self.session
        self.addSubview(coachingOverlay)
    }
}
