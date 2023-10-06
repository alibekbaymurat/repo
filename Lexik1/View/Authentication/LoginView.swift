//
//  LoginView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 18.08.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Group {
                    TextField("E-mail", text: $email)
                    
                    TextField("Пароль", text: $password)
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                Button("Войти") {
                    authVM.login(withEmail: email, password: password)
                }
                
                Section {
                    NavigationLink("Регистрация") {
                        RegistrationView()
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
