//
//  ViewController+ARSCNViewDelegate.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 11/11/23.
//

import ARKit

extension ViewController {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        self.focusNode.updateFocusNode()
    }
}
