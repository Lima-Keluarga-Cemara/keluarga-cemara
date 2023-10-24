//
//  AreaSceneView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 20/10/23.
//

import SwiftUI

struct SceneAreaView: View {
    @State private var lightValue: Float = 0
    
    var body: some View {
        ZStack{
            SceneAreaViewWrapper(lightValue: lightValue)
            
            VStack{
                Spacer()
                VStack{
                    Slider(value: $lightValue, in: 0...(2 * Float.pi))
                    Text("\(lightValue, specifier: "%.1f") Point")
                }
                .padding(.horizontal, 20)
                .frame(width: 400)
                .background(Color.black.opacity(0.3))
            }
            .padding(.vertical, 20)
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SceneAreaView()
}
