//
//  PlanetView.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-14.
//

import SwiftUI


struct PlanetView: View {
    @State private var selectedPlanetIndex: Int?
    
    var body: some View {
        NavigationView {
            List(planetData.indices, id: \.self) { index in
                NavigationLink(destination: DetailView(selectedPlanetIndex: self.$selectedPlanetIndex, planetIndex: index)) {
                    PlanetRow(planet: planetData[index])
                }
            }
            .listStyle(PlainListStyle())
            .frame(maxWidth: .infinity)
        }
    }
}
struct PlanetRow: View {
    var planet: Planet
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
            .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorNew"), Color("ColorNew")]), startPoint: .top, endPoint: .bottom))
                .frame(width: 370, height: 150)
                .padding(.horizontal)
                .shadow(color: Color.black, radius: 5, x: 5, y: 5)
            
            HStack(spacing: 20) {
                Image(planet.image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(30)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.70), radius: 10, x: 6, y: 8)
                
                Text(planet.title)
                    .font(.title2.bold())
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        
    }
}

struct PlanetView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetView()
    }
}


