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
    case resultfeature
    case onboarding
 
    
    
    @ViewBuilder
    var view: some View{
        switch self{
        case .roomscan:
            RoomViewIteration()
        case .resultfeature:
            ResultScanYogi()
        case .onboarding:
            OnboardingView()
        }
    }
}
