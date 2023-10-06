//
//  RegistrationView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 18.08.2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        VStack {
            Form {
                Group {
                    TextField("E-mail", text: $email)
                    
                    TextField("Имя пользователя", text: $username)
                    
                    TextField("Имя и фамилия (опционально)", text: $fullname)
                    
                    TextField("Пароль", text: $password)
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                Section {
                    Button("Зарегистрироваться") {
                        authVM.registerUser(email: email,
                                               password: password,
                                               username: username,
                                               fullname: fullname)
                    }
                }
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
