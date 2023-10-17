//
//  ContentView.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-14.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1
    @StateObject var data = SpaceAPI()
    @State private var opac = 0.0
    @State var isHidden: Bool = false
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // Home Tab
            NavigationView{
                PlanetView()
                    .navigationBarTitle("")
                    .navigationBarHidden(isHidden)
                    .onAppear { self.isHidden = true }
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(1)
            
            // News Tab
            NavigationView {
                NewsView()
                    .opacity(opac)
                    .environmentObject(data)
                    .onAppear {
                        data.getData()
                        
                        withAnimation(.easeIn(duration: 2)) {
                            opac = 1.0
                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationBarTitle("Space News", displayMode: .inline)
                    .padding(0)
            }
            .tabItem {
                Image(systemName: "globe")
                Text("News")
            }
            .tag(2)
            
            // Calculator Tab
            CalculatorView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Calculator")
                }
                .tag(3)
            
            // Profile Tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}










