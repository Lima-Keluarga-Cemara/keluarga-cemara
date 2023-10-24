//
//  ViewPath.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 19/10/23.
//

import Foundation
import SwiftUI

enum ViewPath: Hashable{
    //create your screen in here using enum
    case introduction
    case roomscan
    case roomscanresult
    case plantrecomend
    case plantrecomenddetail
    case orientationConfirmation
    
    
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
        }
        
    }
}
