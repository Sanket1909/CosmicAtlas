//
//  SignupView.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-14.
//

import SwiftUI
import Firebase

struct NewProfile {
    let uid, email, fullname, phonenumber: String
}

class ProfileViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var userProfile: NewProfile?
    @Published var isUserCurrentlyLoggedOut = false
    
    func createUserInFirestore(uid: String, email: String, fullname: String, phonenumber: String) {
        let userData: [String: Any] = [
            "uid": uid,
            "email": email,
            "fullname": fullname,
            "phonenumber": phonenumber
        ]
        
        FirebaseManager.shared.firestore.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                self.errorMessage = "Failed to create user data in Firestore: \(error)"
                print("Failed to create user data in Firestore:", error)
            } else {
                self.errorMessage = ""
            }
        }
    }
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}

struct SignupView: View {
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var isShowPlanetView = false
    let didCompletedLoginProcess: () -> ()
    
    @ObservedObject private var vm = ProfileViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .blue, .pink], startPoint: .bottomTrailing, endPoint: .topLeading)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.6)
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 150)
                    .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: 4)
                Spacer()
                Text("SignUp")
                    .font(.title)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                VStack {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    TextField("FullName", text: $fullName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    TextField("PhoneNumber", text: $phoneNumber)
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
                    createNewAccount()
                }) {
                    Text("SignUp")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                NavigationLink("", destination: ContentView().navigationBarBackButtonHidden(true), isActive: $isShowPlanetView)
                    .opacity(0)
                NavigationLink(destination: LoginView(didCompletedLoginProcess: {})) {
                    Text("Already have an account? Login")
                        .foregroundColor(.white)
                        .underline()
                        .padding()
                        .navigationBarBackButtonHidden(true)
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.vm.errorMessage = "Failed to create user: \(err)"
                return
            }
            
            if let uid = result?.user.uid {
                // Call the function to create user data in Firestore
                vm.createUserInFirestore(uid: uid, email: email, fullname: fullName, phonenumber: phoneNumber)
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            
            self.vm.errorMessage = "Successfully created user: \(result?.user.uid ?? "")"
            self.isShowPlanetView = true
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(didCompletedLoginProcess: {})
    }
}
