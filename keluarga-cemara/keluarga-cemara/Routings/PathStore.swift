//
//  PathStore.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 19/10/23.
//

import Foundation
import SwiftUI

class PathStore: ObservableObject{
    @Published var path: NavigationPath = NavigationPath()
    
    func popToRoot(){
        path = NavigationPath()
    }
    
    func navigateToView(_ viewPath: ViewPath){
        path.append(viewPath)
    }
}
