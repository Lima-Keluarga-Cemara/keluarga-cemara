//
//  KeluargaCemara.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 18/10/23.
//

import SwiftUI
import RoomPlan

@main
struct KeluargaCemara: App {

    var body: some Scene {
        WindowGroup {
           checkDeciveView()
        }
    }
}


@ViewBuilder
func checkDeciveView() -> some View {
    if RoomCaptureSession.isSupported{
        MainView()
    } else {
        UnsupportedDeviceView()
    }
}


