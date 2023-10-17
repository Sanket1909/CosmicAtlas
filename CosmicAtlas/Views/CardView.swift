//
//  CardView.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-14.
//

import SwiftUI

struct CardView: View {
    var planet: Planet
    @State private var isAnimate:Bool = false
    var body: some View {
        ZStack {
            VStack(spacing:20){
                
                Image(planet.image)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal,30)
                    .shadow(color: Color(red:0,green:0,blue:0,opacity: 0.20), radius: 10, x: 6, y: 8)
                    .scaleEffect(isAnimate ? 1.0 : 0.6)
                Text(planet.title)
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red:0,green:0,blue:0,opacity: 0.15), radius: 2, x: 2, y: 2)
                Text(planet.headline)
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,16)
                    .frame(maxWidth:450)
                buttonview()
            }
        }
        .onAppear{
            withAnimation(.easeOut(duration: 0.5)){
                isAnimate = true
            }
        }
        .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: planet.gradientColors), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(.horizontal,20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(planet: planetData[3])
            .previewLayout(.fixed(width: 320, height: 640))
    }
}


