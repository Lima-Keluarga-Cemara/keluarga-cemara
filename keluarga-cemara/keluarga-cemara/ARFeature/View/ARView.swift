//
//  ARView.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 31/10/23.
//

import SwiftUI

struct ARView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isFirstButtonChecked = false
    @State private var isSecondButtonChecked = false
    @State private var isThirdButtonChecked = false
    @State private var isFourthButtonChecked = false
    @State private var isShowDetailInfo = false
    @StateObject private var sunManager = LocationManager()
    @State private var selectedText: String?
    @State private var selectedDesc : String?
    @EnvironmentObject private var pathStore: PathStore

    
    var body: some View {
        ZStack{
            Image(.ar)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                
                if isSecondButtonChecked{
                    SliderView()
                        .padding(.top,20)
                }
                
                VStack{
                    if isFirstButtonChecked{
                        ZStack{
                            //                            MARK: Keterangan Shade 1
                            if let selectedText = self.selectedText , let  selectedDesc = self.selectedDesc , isShowDetailInfo {
                                DetailInfoShade(title: selectedText, desc: selectedDesc)
                                    .offset(x: 0, y: -20)
                            }
                           
                            VStack(spacing: 0){
                                Text("Partial Shade")
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.gray.opacity(0.9))
                                    .cornerRadius(16)
                                    .offset(x:40)
                                DashedLineVertical()
                                    .frame(height: 140)
                                ZStack{
                                    Circle()
                                        .fill(Color.gray.opacity(0.8))
                                        .frame(width: 20, height: 20)
                                    Circle()
                                        .fill(Color.white.opacity(0.8))
                                        .frame(width: 10, height: 10)
                                }
                            }
                            .offset(x: -70, y: 200)
                            .onTapGesture {
                                isShowDetailInfo.toggle()
                                selectedText = "Partial Shade"
                                selectedDesc = "This area get 2-4 hours of direct sunlight per day"
                            }
                            
                            //                            MARK: Keterangan shade 2
                            VStack(spacing: 0){
                                Text("Partial Sun")
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.gray.opacity(0.9))
                                    .cornerRadius(16)
                                    .offset(x:-40)
                                DashedLineVertical()
                                    .frame(height: 70)
                                ZStack{
                                    Circle()
                                        .fill(Color.gray.opacity(0.8))
                                        .frame(width: 20, height: 20)
                                    Circle()
                                        .fill(Color.white.opacity(0.8))
                                        .frame(width: 10, height: 10)
                                }
                            }
                            .offset(x:130, y:270)
                            .onTapGesture {
                                isShowDetailInfo.toggle()
                                selectedText = "Partial Sun"
                                selectedDesc = "This area gets 4-6 hours of direct sunlight per day"
                            }

                        }
                    }
                    if isThirdButtonChecked{
                        VStack{
                            Text("2 Hours")
                                .offset(x: -20, y : 130)
                            Text("3 Hours")
                                .offset(x: 40, y : 150)
                            Text("4 Hours")
                                .offset(x: 100, y : 160)
                        }
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                
                if isFourthButtonChecked{
                    Text("\(sunManager.resultOrientationDirection ?? "Partial Sun")")
                        .font(.system(size: 14,weight: .medium, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: 294, height: 67)
                        .padding()
                        .background(Color(.grayTextResultOrientation))
                        .cornerRadius(14)
                        .padding(.bottom, 34)
                }
                
                GeneralCostumButton(title: "Get veggies recommendation") {
                    pathStore.navigateToView(.plantrecomend)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.backward.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(Color(.white))
                    
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    ButtonMenu(action: $isFirstButtonChecked, title: "Shade Information")
                    ButtonMenu(action: $isSecondButtonChecked, title: "Shade Pattern")
                    ButtonMenu(action: $isThirdButtonChecked, title: "Sun Duration")
                    ButtonMenu(action: $isFourthButtonChecked, title: "Garden Orientation")
                } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.system(size: 32))
                    
                }
                .foregroundColor(Color(.white))
            }
        })
    }
    
}

#Preview {
    ARView()
}

struct DetailInfoShade : View {
    let title : String
    let desc : String
    
    var body: some View {
        VStack(spacing: 10){
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
            Text(desc)
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
        }
        .frame(width: 161, height: 100)
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(14)


    }
}






