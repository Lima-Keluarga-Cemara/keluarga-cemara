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
    case example
    case exampleWithParam(String)
    
    
    @ViewBuilder
    var view: some View{
        switch self{
        case .example:
            ExampleRouteView()
        case .exampleWithParam(_):
            ExampleRouteView()
        }
    }
}
