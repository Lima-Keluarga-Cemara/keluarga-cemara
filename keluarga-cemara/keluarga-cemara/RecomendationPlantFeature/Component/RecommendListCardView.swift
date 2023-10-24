//
//  RecommendCardView.swift
//  keluarga-cemara
//
//  Created by Muhammad Afif Maruf on 23/10/23.
//

import SwiftUI

struct RecommendListCardView: View {
    let title: String
    let columnGrid: [GridItem]
    var action: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading){
            Text("Partial Sun Veggies")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(11)
            LazyVGrid(columns: columnGrid){
                ForEach(1...4, id: \.self) { _ in
                    RecommendCardView()
                        .onTapGesture {
                            action?()
                        }
                }
                
            }
        }.padding(.horizontal, 16)
    }
}

#Preview {
    RecommendListCardView(title: "Partial Sun", columnGrid: [GridItem(.flexible()), GridItem(.flexible())])
}
