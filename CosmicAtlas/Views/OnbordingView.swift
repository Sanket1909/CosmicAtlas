//
//  OnbordingView.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-14.
//

import SwiftUI

struct OnbordingView: View {
    var planet:[Planet] = planetData
    var body: some View {
        TabView{
            ForEach(planet[0...3]){
                item in CardView(planet: item)
                
            }
            
        }
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical,20)
        
    }
}

struct OnbordingView_Previews: PreviewProvider {
    static var previews: some View {
        OnbordingView(planet: planetData)
    }
}

