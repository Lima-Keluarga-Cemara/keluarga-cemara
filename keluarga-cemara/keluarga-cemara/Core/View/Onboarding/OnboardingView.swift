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
                        HeadlineOnboardingView(geometry: geometry, title: "Understand your gardening area better", subTitle: "Get the garden orientation precisely with stand and face the oping in your area")
                            .tag(0)
                        
                        HeadlineOnboardingView(geometry: geometry, title: "Understand your gardening area better", subTitle: "Get the garden orientation precisely with stand and face the oping in your area")
                            .tag(1)
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .padding(.bottom, 73)
                }
                
                VStack(alignment: .trailing){
                    Spacer()
                    HStack{
                        Spacer()
                        StandardButton(text: "Start", color: Color(.primary),colorText: .black, width: 96, height: 44) {
                            pathStore.navigateToView(.roomscan)
                        }
                    }
                }
                .frame(width: geometry.size.width)
                .padding(.bottom, 55)
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
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.bottom, 20)
            
            Text(subTitle)
                .font(.headline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(.subheadline))
        }
        .frame(height: geometry.size.height * 0.58)
        .padding(16)
    }
}
