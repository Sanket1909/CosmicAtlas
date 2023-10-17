//
//  NoneView.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-15.
//

import SwiftUI
import Lottie
struct CalculatorView: View {
    let planets = [
        PlanetCalculateData(title: "Mercury", surfaceGravity: 3.7, orbitPeriod: 88),
        PlanetCalculateData(title: "Venus", surfaceGravity: 8.87, orbitPeriod: 225),
        PlanetCalculateData(title: "Earth", surfaceGravity: 9.81, orbitPeriod: 365),
        PlanetCalculateData(title: "Mars", surfaceGravity: 3.711, orbitPeriod: 687),
        PlanetCalculateData(title: "Jupiter", surfaceGravity: 24.79, orbitPeriod: 4332.82),
        PlanetCalculateData(title: "Saturn", surfaceGravity: 10.44, orbitPeriod: 10755.70),
        PlanetCalculateData(title: "Uranus", surfaceGravity: 8.69, orbitPeriod: 30687.15),
        PlanetCalculateData(title: "Neptune", surfaceGravity: 11.15, orbitPeriod: 60190.03),
        PlanetCalculateData(title: "Pluto", surfaceGravity: 0.58, orbitPeriod: 247.92),
        PlanetCalculateData(title: "Sun", surfaceGravity: 274.13, orbitPeriod: 226000000),
        PlanetCalculateData(title: "Moon", surfaceGravity: 1.625, orbitPeriod: 27),
        
    ]
    
    @State private var selectedPlanetIndex = 0
    @State private var age = ""
    @State private var weight = ""
    @State private var showingResult = false
    @State private var isCalculating = false
    var planet: PlanetCalculateData {
        planets[selectedPlanetIndex]
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    
                    Text("Select a planet:")
                        .font(.headline)
                        .foregroundColor(.white)
                    NavigationLink(destination: ResultView(age: calculateAge(), weight: calculateWeight(), planet: planet), isActive: $showingResult) {
                        EmptyView()
                    }
                    .opacity(0)
                    
                    Menu(planet.title) {
                        ForEach(0..<planets.count, id: \.self) { index in
                            Button(planets[index].title) {
                                selectedPlanetIndex = index
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    Text("Enter your age on Earth:")
                        .font(.headline)
                        .padding(.top).foregroundColor(.black)
                    
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    
                    Text("Enter your weight on Earth (kg):")
                        .font(.headline)
                        .padding(.top).foregroundColor(.black)
                    
                    TextField("Weight", text: $weight)
                    
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    
                    
                    Button(action: {
                        
                        showingResult.toggle()
                        
                        
                        withAnimation(Animation.easeInOut(duration: 0.1).repeatForever(autoreverses: true)) {
                            isCalculating.toggle()
                        }
                        
                        // Add a delay to stop the animation after a certain time
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            isCalculating = false
                        }
                    }) {
                        ZStack {
                            Image("calculate")
                                .resizable()
                                .frame(width: 190, height: 190)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .scaleEffect(isCalculating ? 1.05 : 1.0)
                                .offset(y: isCalculating ? -10 : 0)
                            
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 90)
                    .onAppear {
                        isCalculating.toggle()
                    }
                    
                    
                    
                    Spacer()
                }
                
            }}
    }
    
    func calculateAge() -> String {
        if let earthAge = Double(age), earthAge >= 0 {
            let planet = planets[selectedPlanetIndex]
            let planetAge = earthAge / (365 / planet.orbitPeriod)
            return String(format: "%.2f", planetAge)
        }
        return "Invalid input"
    }
    
    func calculateWeight() -> String {
        if let earthWeight = Double(weight), earthWeight >= 0 {
            let planet = planets[selectedPlanetIndex]
            let planetWeight = earthWeight * (planet.surfaceGravity / 9.81)
            return String(format: "%.2f", planetWeight)
        }
        return "Invalid input"
    }
    
    
    struct CalculatorView_Previews: PreviewProvider {
        static var previews: some View {
            CalculatorView()
        }
    }
    
    struct PlanetCalculateData {
        let title: String
        let surfaceGravity: Double // Relative to Earth's gravity
        let orbitPeriod: Double // Earth days for one orbit
        
        init(title: String, surfaceGravity: Double, orbitPeriod: Double) {
            self.title = title
            self.surfaceGravity = surfaceGravity
            self.orbitPeriod = orbitPeriod
        }
    }
    
    
    
    
    struct LottieView: UIViewRepresentable {
        let loopMode: LottieLoopMode
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
        
        func makeUIView(context: Context) -> Lottie.LottieAnimationView {
            let animationView = LottieAnimationView(name: "animation_ln0x2yob.json")
            animationView.play()
            animationView.loopMode = loopMode
            animationView.contentMode = .scaleAspectFit
            return animationView
        }
    }
    
    struct ResultView: View {
        let age: String
        let weight: String
        let planet: PlanetCalculateData
        
        var body: some View {
            ZStack {
                LottieView(loopMode: .loop)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Your age on \(planet.title): \(age) years")
                        .font(.custom("Avenir-Heavy", size: 30))
                        .foregroundColor(.orange)
                        .padding()
                    
                    Text("Your weight on \(planet.title): \(weight) kg")
                        .font(.custom("Avenir-Medium", size: 28))
                        .foregroundColor(.green)
                        .padding()
                    
                    Spacer()
                }
            }
        }
    }
    
    
    
}











