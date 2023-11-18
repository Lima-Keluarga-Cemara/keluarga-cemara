//
//  Text+Extension.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 10/11/23.
//

import SwiftUI

extension Text {
    func titleOnBoarding() -> some View {
        self
            .font(.system(size: 22, weight: .bold, design: .rounded ))
            .foregroundColor(Color(.black))
    }
    
    func descriptionOnBoarding() -> some View {
        self
            .font(.system(size: 17, weight: .regular, design: .rounded))
            .foregroundColor(Color(.black))
    }
    
    func titleButton() -> some View {
        self
            .font(.system(size: 17, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
    }
    
    func titleButtonBlack() -> some View {
        self
            .font(.system(size: 17, weight: .semibold, design: .rounded))
            .foregroundColor(Color(.black))
    }
    
    func textInstruction() -> some View {
        self
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
    }
    
   

    func titleInstruction() -> some View {
        self
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(Color(.black))
    }
    
    func bodyInstruction() -> some View {
        self
            .font(.system(size: 17, weight: .regular, design: .rounded))
            .foregroundColor(Color(.black))
    }
    
//    MARK: font for veggies recommend screen
    func title1() -> some View {
        self
            .font(.system(size: 25, weight: .semibold, design: .rounded))
            .foregroundColor(Color(.black))
    }
    
    func callout() -> some View {
        self
            .font(.system(size: 16, weight: .regular, design: .rounded))
            .foregroundColor(Color(.black))
    }
    
    func calloutWhite() -> some View {
        self
            .font(.system(size: 16, weight: .regular, design: .rounded))
            .foregroundColor(Color(.white))
    }
    
    func title2() -> some View{
        self
            .font(.system(size: 19, weight: .medium, design: .rounded))
            .foregroundColor(Color(.black))
    }
    
    func titleCapt() -> some View {
        self
            .font(.system(size: 14, weight: .medium, design: .rounded))
            .foregroundColor(Color(.black))
    }
    
    func descCapt() -> some View {
        self
            .font(.system(size: 14, weight: .regular, design: .rounded))
            .foregroundColor(Color(.textGray))
    }

}
