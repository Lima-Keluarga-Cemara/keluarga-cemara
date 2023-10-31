//
//  Scene.swift
//  ExploringSceneKit
//
//  Created by Fabrizio Duroni on 28.08.17.
//


import Foundation
import CoreGraphics

@objc protocol Scenee {
//    func actionForOnefingerGesture(withLocation location: CGPoint, andHitResult hitResult: [Any]!)
    @objc optional func actionForTwofingerGesture()
}
