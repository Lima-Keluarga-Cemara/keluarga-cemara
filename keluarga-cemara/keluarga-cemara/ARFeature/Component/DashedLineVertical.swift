//
//  DashedLineVertical.swift
//  keluarga-cemara
//
//  Created by tiyas aria on 31/10/23.
//

import SwiftUI

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
    DashedLineVertical()
        .background(Color.red)
}
