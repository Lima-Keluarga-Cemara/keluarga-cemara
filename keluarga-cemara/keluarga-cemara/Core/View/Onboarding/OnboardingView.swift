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
    @State private var selectedImage : ImageResource = .onboardingOne
    
    //change color
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(resource: .primary)
        UIPageControl.appearance().pageIndicatorTintColor = .gray
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                //image
                Image(currentIndex == 0 ? .onboardingOne : .onboardingTwo)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack{
                    TabView(selection: $currentIndex){
                        HeadlineOnboardingView(geometry: geometry, title: "Harness sunlight to start your vegetable cultivation", subTitle: "Scan the area and map the sunlight to know better your garden orientation")
                            .tag(0)
                        
                        HeadlineOnboardingView(geometry: geometry, title: "Transform your urban oasis into a thriving vegetables garden", subTitle: "Get veggies recommendations tailored to sunlight and shade in your garden")
                            .tag(1)
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .padding(.bottom, 113)
                }
                
                VStack(alignment: .trailing){
                    Spacer()
                    VStack{
                        Spacer()
                        StandardButton(text: "Start", color: Color(.primary), colorText: .white, width: geometry.size.width * 0.92, height: 56) {
                            pathStore.navigateToView(.instruction)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                }
                .frame(width: geometry.size.width)
                .animation(.easeInOut, value: currentIndex == 0 ? true : false)
                .isHidden(currentIndex == 0 ? true : false, remove: true)
            }
            .ignoresSafeArea()
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
    
    var body: some View {
        VStack{
            Spacer()
            Text(title)
                .font(.system(size: 22))
                .bold()
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.bottom, 20)
            
            Text(subTitle)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(.subheadline))
                .padding(.horizontal, 20)
        }
        .frame(height: geometry.size.height * 0.7)
        .padding(16)
    }
}


