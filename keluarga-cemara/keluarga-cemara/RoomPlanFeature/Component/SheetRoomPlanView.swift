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
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 28))
                    })
                }
                
                VStack(alignment : .leading , spacing: 16, content: {
                    Text("Follow steps as instruction below:")
                        .titleInstruction()
                    
                    ItemInstruction(image: .firstIcon, title: "1. Tap ‘Record button’ to start scanning every corner of your garden area.")
                    
                    ItemInstruction(image: .secondIcon, title: "2. After done scanning, tap ‘Record button’ again to stop scanning.")
                    
                    ItemInstruction(image: .thirdIcon, title: "3. Then, you will receive a 3D modeling result of your garden.")
                    
                })
              
            }
            .padding(.horizontal, 16)
        }
    }
}


#Preview {
    SheetRoomPlanView()
}
