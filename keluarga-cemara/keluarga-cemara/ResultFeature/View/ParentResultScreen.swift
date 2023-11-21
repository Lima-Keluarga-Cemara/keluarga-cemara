//
//  ParentResultScreen.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 20/11/23.
//

import Foundation
import SwiftUI
import SceneKit

struct MappingShadowScreen : View {
    @EnvironmentObject private var pathStore: PathStore
    @State private var isLoading : Bool = true
    @StateObject var lightPosition = LightPosition()
    @StateObject private var sunManager = LocationManager()
    @State private var sliderValue: Double = 0.0
    @State private var isShowingSheet = true
    @State private var isTapped = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color(.graybg).ignoresSafeArea()
            
            if isLoading{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.brown))
                    .scaleEffect(4)
                    .frame(height: 500)
                
            } else {
                SceneKitSliderView(lightPosition: lightPosition, scene: PhysicallyBasedShadowScene(lightPosition: lightPosition))                    .ignoresSafeArea()
            }
            
            VStack{

                TimeSlider(sliderValue: $sliderValue, locationManager: sunManager, lightPosition: lightPosition)
                Spacer()

            }

        }

        .navigationBarBackButtonHidden()
        .onAppear {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2, execute: {
                isLoading = false
            })
        }
    }
}


struct ParentResultScreen : View {
    @State private var currentTab : Int = 0

    var body: some View {
        ZStack{
            Color(.graybg).ignoresSafeArea()
            VStack{
                TabBarView(currentTab: $currentTab)
                if currentTab == 0 {
                    MappingShadowScreen()
                } else {
                    ResultScan()
                }
            }
            .padding(.top)
            .ignoresSafeArea()

        }
       
    }
}

struct TabBarView : View {
    @Binding var currentTab: Int
    var tabBarOptions : [String] = ["Explore", "Result"]
    var body: some View {
        HStack(spacing: 30){
            ForEach(Array(zip(self.tabBarOptions.indices, self.tabBarOptions)), id: \.0) { index,name in
                TabBarItem(currentTab: self.$currentTab, tabBarItemName: name, tab: index)
            }
        }
        .frame(height: 80)
    }
}
struct TabBarItem : View {
    @Binding var currentTab : Int
    var tabBarItemName : String
    var tab : Int
    
    var body: some View {
        Button(action: {
            self.currentTab = tab
        }, label: {
            VStack{
                Spacer()
                if currentTab == tab {
                    Text(tabBarItemName)
                    .titleButtonBlack()
                    Color.black.frame( width: 30,height: 3)
                } else {
                    Text(tabBarItemName)
                    .titleButton()
                    Color.clear.frame( width: 30,height: 3)

                }
            }
        })
        .buttonStyle(.plain)
    }
}

#Preview{
    ParentResultScreen()
}
