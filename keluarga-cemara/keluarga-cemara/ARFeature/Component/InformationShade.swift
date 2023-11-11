//
//  DashedLineVertical.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 31/10/23.
//

import SwiftUI

struct InformationShadeView : View {
    @State private var sheetOpen = false

    var body: some View {
        VStack(spacing: 0){
            Text("Partial Shade")
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .padding()
                .background(Color.gray.opacity(0.9))
                .cornerRadius(16)
                .offset(x:-40)
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
        .onTapGesture {
            sheetOpen = true
            print("gesture add")
        }
        .sheet(isPresented: $sheetOpen, content: {
            RecommendListCardView(title: "Partial Sun", data: [RecommendPlantMock().celeryPlant, RecommendPlantMock().cabbagePlant], columnGrid: [GridItem(.flexible()), GridItem(.flexible())])
                .presentationDetents([.medium, .large])

        })
    }
}

struct DashedLineVertical: View {
    var body: some View {
           GeometryReader { geometry in
               Path { path in
                   let spacing: CGFloat = 10 // Adjust the spacing between dashes
                   let numberOfDashes = Int(geometry.size.height / spacing)
                   
                   for i in 0..<numberOfDashes {
                       let y = CGFloat(i) * spacing
                       path.move(to: CGPoint(x: geometry.size.width / 2, y: y))
                       path.addLine(to: CGPoint(x: geometry.size.width / 2, y: y + spacing / 2))
                   }
               }
               .stroke(Color.white, style: StrokeStyle(lineWidth: 1, dash: [5]))

           }

       }
}

#Preview {
    InformationShadeView()
        .background(Color.red)
}
