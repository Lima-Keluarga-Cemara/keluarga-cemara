//
//  ContentView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 17/10/23.
//

import SwiftUI

struct ContentView : View {
    @EnvironmentObject private var pathStore: PathStore
    
    var body: some View {
        IntroductionView()
    }
}


#Preview {
    ContentView()
}
