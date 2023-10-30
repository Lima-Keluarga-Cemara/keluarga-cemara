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
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.black)
                        .font(.system(size: 28))
                        .padding(.trailing)
                })
            }
            
            VStack(alignment : .leading , spacing: 14, content: {
                Text("Please take note of the \nfollowing steps:")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .padding(.leading, 22)
                  
                
                ItemInstruction(image: .thirdIcon, title: "1. Tap the ‘Record button’ to start scanning every corner of your garden area", width: 44, height: 44, textSize: 14, textColor: .black)
                
                ItemInstruction(image: .fourthIcon, title: "2. After you have done scanning, tap the ‘Record button’ to stop scanning", width: 44, height: 44, textSize: 14, textColor: .black)
                
                ItemInstruction(image: .fifthIcon, title: "3. Then, you will receive a 3D modeling result of your garden", width: 44, height: 44, textSize: 14, textColor: .black)
            })
          
        }
    }
}


#Preview {
    SheetRoomPlanView()
}
