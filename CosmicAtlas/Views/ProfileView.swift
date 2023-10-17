//
//  ProfileView.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-30.
//

import SwiftUI
import Firebase

struct SignupProfile {
    let uid, email, fullname, phonenumber: String
}

class UserViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var userProfile: SignupProfile?
    @Published var isUserCurrentlyLoggedOut = false
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find Firebase UID"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = ""
                return
            }
            
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let fullname = data["fullname"] as? String ?? ""
            let phonenumber = data["phonenumber"] as? String ?? ""
            self.userProfile = SignupProfile(uid: uid, email: email, fullname: fullname, phonenumber: phonenumber)
        }
    }
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut = true
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}

struct ProfileImage: View {
    var userProfile: SignupProfile?
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.blue)
                .overlay(
                    Text(userProfile?.fullname.prefix(1).uppercased() ?? "")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                )
        }
    }
}

struct ProfileView: View {
    @State var shouldShowLogOutOptions = false
    @State var isLoggedOut = false
    @ObservedObject private var vm = UserViewModel()
    @State private var firstname = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileImage(userProfile: vm.userProfile)
                    .padding()
                
                Form {
                    Section(header: Text("Your Info")) {
                        TextField("First Name", text: $firstname)
                        TextField("Phone Number", text: $phoneNumber)
                            .disabled(!vm.isUserCurrentlyLoggedOut)
                        TextField("Email", text: $email)
                            .disabled(!vm.isUserCurrentlyLoggedOut)
                    }
                }
            }
            .onAppear {
                vm.fetchCurrentUser()
                if let userProfile = vm.userProfile {
                    firstname = userProfile.fullname
                    phoneNumber = userProfile.phonenumber
                    email = userProfile.email
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        shouldShowLogOutOptions.toggle()
                    }) {
                        Label("Logout", systemImage: "square.and.arrow.down")
                    }
                    .alert(isPresented: $shouldShowLogOutOptions) {
                        Alert(
                            title: Text("Logout"),
                            message: Text("Are you sure you want to log out?"),
                            primaryButton: .default(Text("Yes")) {
                                handleLogout()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isLoggedOut) {
            LoginView(didCompletedLoginProcess: {
                isLoggedOut = false
            })
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private func handleLogout() {
        vm.handleSignOut()
        isLoggedOut = true
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
