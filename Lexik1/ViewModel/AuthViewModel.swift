//
//  AuthViewModel.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 20.08.2023.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login( withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to login \(error.localizedDescription)")
                return
            }
            self.userSession = result?.user
            self.fetchUser()
        }
    }
    
    func registerUser(email: String, password: String, username: String, fullname: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error  {
                print("DEBUG: Error \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            let data = ["email": email,
                        "username": username.lowercased(),
                        "fullname": fullname,
                        "uid": user.uid]
            COLLECTION_USERS.document(user.uid).setData(data) { _ in
                self.userSession = user
                self.fetchUser()
            }
        }
    }
    
    func signOut() {
        userSession = nil
        currentUser = nil
        try? Auth.auth().signOut()
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            let user = User(dictionary: data)
            self.currentUser = user
        }
    }
}
