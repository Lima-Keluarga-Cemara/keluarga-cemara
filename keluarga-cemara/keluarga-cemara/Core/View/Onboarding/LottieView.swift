//
//  LottieView.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 10/11/23.
//

import Foundation
import SwiftUI
import Lottie

struct LottieView : UIViewRepresentable{
    let loopMode : LottieLoopMode
    let resource : String
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: resource)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
