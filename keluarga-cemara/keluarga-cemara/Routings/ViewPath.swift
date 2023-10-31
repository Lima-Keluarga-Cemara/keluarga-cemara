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
    case roomscan
    case roomscanresult
    case plantrecomend
    case resultfeature
    case plantrecomenddetail(RecommendPlantModel)
    case onboarding
    case instruction
    case arview
    
    
    @ViewBuilder
    var view: some View{
        switch self{
        case .roomscan:
            RoomViewIteration()
        case .roomscanresult:
            ResultScan()
        case .plantrecomend:
            RecommendationPlantView()
        case .resultfeature:
            SceneKitView(lightPosition: LightPosition(), scene: PhysicallyBasedScene(lightPosition: LightPosition()))
        case .plantrecomenddetail(let plant):
            RecommendationPlantDetailView(plant: plant)
        case .onboarding:
            OnboardingView()
        case .instruction:
            InstructionView()
        case .arview:
            ARView()
        }
    }
}
