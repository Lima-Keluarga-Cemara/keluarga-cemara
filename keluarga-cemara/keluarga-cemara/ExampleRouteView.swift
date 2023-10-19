//
//  ExampleRouteView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 19/10/23.
//

import SwiftUI

struct ExampleRouteView: View {
    @EnvironmentObject private var pathStore: PathStore
    var data: String?
    
    var body: some View {
        VStack{
            Text("Hello, \(data ?? "World")")
            Button("Ar Mode") {
                goToARView()
            }
        }
        .navigationDestination(for: ViewPath.self) { viewPath in
            withAnimation {
                viewPath.view
            }.transition(.slide)
        }
    }
    
    func goToARView(){
        pathStore.navigateToView(.arview)
        print(pathStore.path.count)
    }
}

#Preview {
    ExampleRouteView()
}
