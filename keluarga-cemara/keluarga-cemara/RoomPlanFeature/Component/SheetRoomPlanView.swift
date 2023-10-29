//
//  SheetRoomPlanView.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 27/10/23.
//

import SwiftUI

struct SheetRoomPlanView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack{
            Image("bg_sheet")
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 28))
                            .padding()
                    })
                }
                
                
                ItemInstruction(image: .firstIcon, title: "Bring your phone to the area where you will start gardening")
                ItemInstruction(image: .secondIcon, title: "Face the toward side where sun light come")
                ItemInstruction(image: .thirdIcon, title: "Move your phone camera towards every corner of your garden area")
                ItemInstruction(image: .fourthIcon, title: "After you done scanning your area click done button")
                ItemInstruction(image: .fifthIcon, title: "Then you will get 3D modeling result of your garden")
                Spacer()
            }
        }
    }
}

struct ItemInstruction : View {
    let image : ImageResource
    let title : String
    
    var body: some View {
        HStack(spacing: 14){
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.graySheet))
                    .frame(width: 44, height: 44)

                           
                Image(image)
                    
            }
            
            Text(title)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
        }
        .padding(.bottom,12)
        .padding(.horizontal, 22)
    }
}

#Preview {
    SheetRoomPlanView()
}
