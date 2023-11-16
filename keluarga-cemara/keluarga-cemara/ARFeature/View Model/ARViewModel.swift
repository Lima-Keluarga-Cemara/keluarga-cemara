//
//  ARViewModel.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 12/11/23.
//

import Foundation

class ARViewModel: ObservableObject{
    private var viewController: ViewController?
    
    func setViewController(_ viewController: ViewController) {
        self.viewController = viewController
    }
    
    
    func placeModel() {
        viewController?.placeModel()
    }
}
