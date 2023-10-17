//
//  LoginView.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-14.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isShowPlanetView = false
    @State var loginStatusMessage = ""
    let didCompletedLoginProcess: () -> ()
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .blue, .pink]), startPoint: .bottomTrailing, endPoint: .topLeading)
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 220, height: 150)
                        .shadow(color: Color.black.opacity(0.8), radius: 8, x: 0, y: 4)
                    Spacer()
                    Text("Login")
                        .font(.title)
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                    VStack {
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.vertical)
                    Button(action: {
                        
                        loginUser()
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    NavigationLink("", destination: ContentView(), isActive: $isShowPlanetView)
                        .opacity(0)
                    NavigationLink(destination: SignupView(didCompletedLoginProcess: {})) {
                        Text("Don't have an account? Sign up")
                            .foregroundColor(.white)
                            .underline()
                            .padding()
                            .navigationBarBackButtonHidden(true)
                    }
                    .navigationBarHidden(true)
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true) 
        }
    }
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }else{
                
                print("Successfully logged in as user: \(result?.user.uid ?? "")")
                
                self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
                self.didCompletedLoginProcess()
                self.isShowPlanetView = true
            }
            
        }
    }
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView( didCompletedLoginProcess: {})
    }
}
