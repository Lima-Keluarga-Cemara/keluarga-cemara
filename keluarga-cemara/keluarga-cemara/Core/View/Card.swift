//
//  Card.swift
//  keluarga-cemara
//
//  Created by M Yogi Satriawan on 22/10/23.
//

import SwiftUI

//struct Card<Content: View>: View {
//    let content: Content
//    init(@ViewBuilder content: () -> Content) {
//        self.content = content()
//    }
//    var body: some View {
//        VStack {
//            CardViewGuide()
//        }
//        .frame(maxWidth: .infinity)
//        .background(Color.white)
//        .padding()
//    }
//}



//struct CardViewGuide: View {
//    @StateObject private var locationManager = LocationManager()
//    @State private var buttonOrientation: String = "Unknown"
//
//    
//    var body: some View {
//        VStack(alignment: .leading){
//            Text("How to get garden orientation preciesly")
//                .font(.system(size: 16))
//                .foregroundColor(Color.black)
//            HStack{
//                Spacer()
//                Image("imageSheet2")
//                    .resizable()
//                    .frame(width: 113, height: 69.64)
//                VStack(alignment: .leading){
//                    Text("1. Stand the target location")
//                        .font(.system(size: 16))
//                        .foregroundColor(Color.black)
//                    Text("Bring your phone and go to the area where it will be a garden in your home")
//                        .font(.system(size: 11))
//                        .foregroundColor(Color.black)
//                }
//                
//                
//            }
//            .frame(width: 358, height: 90)
//            .background(Color.primary)
//            .cornerRadius(18)
//            
//            HStack{
//                Image("imageSheet1")
//                    .resizable()
//                    .frame(width: 110, height: 69.64)
//                VStack(alignment: .leading){
//                    Text("2. Direct camera towards the sunlight")
//                        .font(.system(size: 16))
//                        .foregroundColor(Color.black)
//                    Text("Direct your phone camera towards side where sunlight comes to the garden area")
//                        .font(.system(size: 11))
//                        .foregroundColor(Color.black)
//                }
//                
//                
//            }
//            .frame(width: 358, height: 90)
//            .background(Color.primary)
//            .cornerRadius(18)
//            
//            StandardButton(
//                text: "See garden orientaion",
//                color: Color("primaryGreen"),
//                width: 320,
//                height: 56,
//                action: {
//                    buttonOrientation = locationManager.orientationDirection
//                    print(buttonOrientation)
//                    
//                })
//            
//            
//        }
//        
//    }
//}



struct CardViewOrientation: View {
    @StateObject private var locationManager = LocationManager()
    @State private var buttonOrientation: String = "Unknown"
    @EnvironmentObject private var pathStore: PathStore

    var body: some View {
        VStack(alignment: .leading){
            Text("Garden orientation")
                .font(.system(size: 12))
                .foregroundColor(Color.black)
            Spacer().frame(height: 10)
            Text("You have a \(locationManager.orientationDirection)-facing garden")
                .font(.system(size: 20))
                .foregroundColor(Color.black)
                .fontWeight(.bold)
            Spacer().frame(height: 10)
            
            Text("This garden typically get the least sunlight as they are shaded for most of the day. The area tend to be cooler especially during early morning and late afternoon.")
                .font(.system(size: 14))
                .foregroundColor(Color.black)
                .fontWeight(.medium)
            
            
            Divider().padding(.vertical, 16)
            
            Text("Are you sure the target location is corect?.")
                .font(.system(size: 14))
                .foregroundColor(Color.black)
                .fontWeight(.medium)
            
            
            HStack{
                StandardButton(
                    text: "Start mapping yout area!",
                    color: Color("primaryGreen"),
                    width: 276,
                    height: 50,
                    action: {
                        buttonOrientation = locationManager.orientationDirection
                        pathStore.navigateToView(.roomscan)
                        print(buttonOrientation)
                    })
                
                
            }.frame(maxWidth: .infinity)
        }.frame(width: 333, height: 303)
            .cornerRadius(16)
    }
}

#Preview {
    CardViewOrientation()
}
