//
//  DetailView.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-15.
//

import SwiftUI
import RealityKit
import SceneKit
struct DetailView: View {
    @Binding var selectedPlanetIndex: Int?
    @State private var isAnimate: Bool = false
    var planetIndex: Int
    
    var body: some View {
        ZStack{
            ScrollView {
                ZStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        SceneView(
                            scene: {
                                let scene = SCNScene(named: planetData[planetIndex].modelName)!
                                
                                
                                return scene
                            }(),
                            options: [.autoenablesDefaultLighting, .allowsCameraControl]
                        )
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                        .padding(.top, -50)
                        
                        Text(planetData[planetIndex].title)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding().foregroundColor(.black)
                        
                        Text(planetData[planetIndex].headline)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding().foregroundColor(.black)
                        
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Group{
                                formatText("Recorded By:", planetData[planetIndex].recordedBy)
                                formatText("First Recorded:", planetData[planetIndex].firstRecord)
                                formatText("Surface Temperature:", planetData[planetIndex].surfaceTemperature)
                                formatText("Orbit Period:", planetData[planetIndex].orbitPeriod)
                                formatText("Orbit Distance:", planetData[planetIndex].orbitDistance)
                                formatText("Known Rings:", planetData[planetIndex].knownRings)
                                formatText("Notable Moons:", planetData[planetIndex].notableMoons)
                                formatText("Known Moons:", planetData[planetIndex].knownMoons)
                                formatText("Equatorial Circumference:", planetData[planetIndex].equatorialCircumference)
                                formatText("Polar Diameter:", planetData[planetIndex].polarDiameter)
                                
                            }
                            formatText("Equatorial Diameter:", planetData[planetIndex].equatorialDiameter)
                            formatText("Mass:", planetData[planetIndex].mass)
                        }
                        .font(.headline)
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    
                }
            }
        }
    }
    // Helper function to format text in the desired format
    private func formatText(_ title: String, _ value: String) -> some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                Text("\(value)")
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
            
            Divider()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedPlanetIndex: .constant(0), planetIndex: 0)
    }
}
