//
//  ViewPath.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 19/10/23.
//

import Foundation
import SwiftUI
import SceneKit

enum ViewPath: Hashable{
    //create your screen in here using enum
    case introduction
    case roomscan
    case roomscanresult
    case plantrecomend
    case plantrecomenddetail
    case orientationConfirmation
    case resultfeature
    
    
    @ViewBuilder
    var view: some View{
        switch self{
        case .introduction:
            IntroductionView()
        case .roomscan:
            RoomView()
        case .roomscanresult:
            ResultScan()
        case .plantrecomend:
            RecommendationPlantView()
        case .plantrecomenddetail:
            RecommendationPlantDetailView()
        case .orientationConfirmation:
            CardViewOrientation()
        case .resultfeature:
            SceneKitView(lightPosition: LightPosition(), scene: PhysicallyBasedScene(lightPosition: LightPosition()))
        }
        
    }
}
