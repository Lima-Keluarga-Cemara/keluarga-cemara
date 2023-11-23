//
//  UnsupportedView.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 22/11/23.
//

import SwiftUI

struct UnsupportedDeviceView: View {
    var body: some View {
        VStack {
            Text("Unsupported Device")
                .font(.title)
                .foregroundColor(.red)
                .padding()
            
            Text("This device does not support Lidar.")
                .padding()
        }
    }
}
