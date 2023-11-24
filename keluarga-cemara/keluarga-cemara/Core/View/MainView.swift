//
//  MainView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 19/10/23.
//

import SwiftUI

struct MainView: View {
    /// Create environment object for pass all data needed
    /// Create environment object for path view
    @StateObject private var pathStore: PathStore = PathStore()
    @StateObject private var locationManager: LocationManager = LocationManager()
    @AppStorage("onboarding") var isOnboardingVisited: Bool = false
   
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            ResultScan()
                .navigationDestination(for: ViewPath.self) { viewPath in
                    withAnimation {
                        viewPath.view
                    }.transition(.slide)
                }
        }
        .environmentObject(pathStore)
        .environmentObject(locationManager)
    }
    
    @ViewBuilder
    func switchView() ->  some View {
        if isOnboardingVisited{
            RoomViewIteration()
        } else {
            OnboardingView()
        }
    }
}


#Preview {
    MainView()
}
