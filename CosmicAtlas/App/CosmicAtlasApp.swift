//
//  CosmicAtlasApp.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-14.
//

import SwiftUI

@main
struct CosmicAtlasApp: App {
    @AppStorage("isOnbording") var isOnbording:Bool = true
    
    var body: some Scene {
        
        WindowGroup {
            if isOnbording{
                OnbordingView()
                
            }else{
                LoginView( didCompletedLoginProcess: {})
                
                
            }
            
        }
    }
}
