//
//  StandardButton.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 29/10/23.
//

import SwiftUI

struct StandardButton: View {
    var text: String
    var color: Color
    var colorText: Color?
    var width: CGFloat // Lebar tombol
    var height: CGFloat // Tinggi tombol
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(colorText ?? Color.white)
        }
        .frame(width: width, height: height) // Menggunakan width dan height dari parameter
        .background(color)
        .cornerRadius(16)
        .padding()
    }
}
