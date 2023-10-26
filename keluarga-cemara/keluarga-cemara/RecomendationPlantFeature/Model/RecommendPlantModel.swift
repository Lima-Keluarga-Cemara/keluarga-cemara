//
//  RecommendPlantModel.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 25/10/23.
//

import Foundation
import SwiftUI

enum typeOfPlant: CaseIterable{
    case fullsun
    case partialsun
    case partialshade
    case fullshade
    
    var title: String {
        switch self {
        case .fullsun:
            return "Full Sun Veggies"
        case .partialsun:
            return "Partial Sun Veggies"
        case .partialshade:
            return "Partial Shade Veggies"
        case .fullshade:
            return "Full Shade Veggies"
        }
    }
}

struct RecommendPlantModel: Hashable {
    let title: String
    let description: String
    let image: ImageResource
    let type: typeOfPlant
    let plantCare: [PlantCareInfo]
}

enum typeOfCareInfo{
    case sunlight
    case watering
    case fertilization
    
    var image: String {
        switch self {
        case .sunlight:
            return "sun.max.fill"
        case .watering:
            return "drop.fill"
        case .fertilization:
            return "leaf.fill"
        }
    }
    
    
}

struct PlantCareInfo: Hashable{
    let typeCareInfo: typeOfCareInfo
    let info: String
}
