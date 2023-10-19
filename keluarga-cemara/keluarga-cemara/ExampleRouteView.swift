//
//  ExampleRouteView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 19/10/23.
//

import SwiftUI

struct ExampleRouteView: View {
    var data: String?
    
    var body: some View {
        Text("Hello, \(data ?? "World")")
    }
}

#Preview {
    ExampleRouteView()
}
