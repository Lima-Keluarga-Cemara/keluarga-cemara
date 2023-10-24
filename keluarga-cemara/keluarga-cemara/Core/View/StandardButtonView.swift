//
//  StardButtonView.swift
//  keluarga-cemara
//
//  Created by M Yogi Satriawan on 22/10/23.
//

import SwiftUI

struct StandardButton: View {
    var text: String
    var color: Color
    var width: CGFloat // Lebar tombol
    var height: CGFloat // Tinggi tombol
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
        }
        .frame(width: width, height: height) // Menggunakan width dan height dari parameter
        .background(color)
        .cornerRadius(16)
        .padding()
    }
}


