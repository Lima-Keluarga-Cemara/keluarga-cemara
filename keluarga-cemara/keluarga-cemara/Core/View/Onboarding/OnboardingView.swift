//
//  OnboardingView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 28/10/23.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var pathStore: PathStore
    @State private var currentIndex = 0
    @AppStorage("onboarding") var isOnboardingVisited: Bool = false


    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(resource: .black)
        UIPageControl.appearance().pageIndicatorTintColor = .gray
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                //image
                Color(.primaryButton).ignoresSafeArea()
                
                
                VStack{
                    TabView(selection: $currentIndex){
                        HeadlineOnboardingView(
                            geometry: geometry,
                            title: "Map the sunlight",
                            subTitle: "Scan the area and map the sunlight to\nknow better your garden orientation.",
                            lottie: "sun.json", currentIndex: 0)
                        .tag(0)
                        
                        HeadlineOnboardingView(
                            geometry: geometry,
                            title: "Veggies recommendation",
                            subTitle: "Get veggies recommendations tailored to sunlight and shade in your garden.",
                            lottie: "leaf.json", currentIndex: 1)
                        .tag(1)
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    
                    GeneralCostumButton(title: currentIndex == 0 ? "Next" : "Get Started") {
                        if currentIndex == 0 {
                            currentIndex += 1
                        } else {
                            isOnboardingVisited = true
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    OnboardingView()
}

struct HeadlineOnboardingView: View {
    var geometry: GeometryProxy
    var title: String
    var subTitle: String
    var lottie : String
    var currentIndex : Int
    
    var body: some View {
        VStack(alignment : .center){
            LottieView(loopMode: .loop, resource: lottie)
                .scaleEffect(currentIndex == 0 ? 1 : 0.5)
                .frame(width: 300, height: 300)
                .padding(.bottom, 100)
            
            Text(title)
                .titleOnBoarding()
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            Text(subTitle)
                .descriptionOnBoarding()
                .multilineTextAlignment(.center)
        }
        .frame(height: geometry.size.height * 0.7)
        .padding(16)
    }
}


