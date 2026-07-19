//
//  LoginView.swift
//  MoodleLogv12c
//
//  Created by Chris Maker on 19/7/2026.
//
import SwiftUI
import FirebaseFirestore
import FirebaseAuth


struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var email = ""
    @State private var password = ""
    
    @State var showAlert = false
    @State var alertMessage = ""
    
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                
                .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

            SecureField("Password", text: $password)
            
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

            Button("Log In") {
                login()
            }
            Button("Sign Up") {
                signUp()
            }
        }
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
            
        }
        
    }
    
    func setUserDetails(){
        appState.userEmail = email
        let db = Firestore.firestore()
        db.collection("Users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
                    if let error = error {
                        print("Error fetching user document: \(error)")
                    } else if let document = snapshot?.documents.first {
                        appState.userDocumentID = document.documentID
                        print("User document ID: \(document.documentID)")
                    }
                }
        
    }
    
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                appState.isLoggedIn = true
                setUserDetails()
            }
        }
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                alertMessage = "Failed to save user info: \(error.localizedDescription)"
                showAlert = true
            } else if let user = authResult?.user {
                let newUser = AppUser(id: nil, email: user.email ?? "")
                let db = Firestore.firestore()
                do {
                    try db.collection("Users").document(user.uid).setData(from: newUser)
                    appState.isLoggedIn = true
                    setUserDetails()
                } catch {
                    alertMessage = "Failed to save user info: \(error.localizedDescription)"
                    showAlert = true
                }
            }
        }
    }
    
    
}

#Preview {
    LoginView()
}

