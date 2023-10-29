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
    case roomscan
    case roomscanresult
    case plantrecomend
    case plantrecomenddetail
    
    
    @ViewBuilder
    var view: some View{
        switch self{
        case .roomscan:
            RoomViewIteration()
        case .roomscanresult:
            ResultScan()
        case .plantrecomend:
            RecommendationPlantView()
        case .plantrecomenddetail:
            RecommendationPlantDetailView()
       
        }
        
    }
}
