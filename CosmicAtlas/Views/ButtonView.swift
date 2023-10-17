//
//  ButtonView.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-14.
//

import SwiftUI

struct buttonview: View {
    @AppStorage("isOnbording") var isOnbording: Bool?
    
    var body: some View {
        Button(action: {
            isOnbording = false
        }) {
            Text("Start")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 100, height: 40) 
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(20)
                .overlay(
                    Capsule()
                        .strokeBorder(Color.white, lineWidth: 2)
                        .padding(2)
                )
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                .overlay(
                    Text("→")
                        .font(.system(size: 20, weight: .bold))
                    
                        .offset(x: -30)
                )
        }
        .accentColor(Color.white)
    }
}

struct buttonview_Previews: PreviewProvider {
    static var previews: some View {
        buttonview()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}


