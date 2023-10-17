//
//  PlanetModel.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-14.
//

import SwiftUI

struct Planet:Identifiable{
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var gradientColors: [Color]
    var modelName:String
    var recordedBy:String
    var firstRecord:String
    var surfaceTemperature:String
    var orbitPeriod:String
    var orbitDistance:String
    var knownRings:String
    var notableMoons:String
    var knownMoons:String
    var equatorialCircumference:String
    var polarDiameter:String
    var equatorialDiameter:String
    var mass:String
    
}
