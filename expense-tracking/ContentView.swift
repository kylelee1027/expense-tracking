//
//  ContentView.swift
//  expense-tracking
//
//  Created by Kyle lee on 5/29/24.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        if userIsLoggedIn {
            // redirect to main page
            HomeView()
        }
        else {
            content
        }
    }
    
    var content: some View {
        ZStack {
            Color(.white)
            VStack(spacing: 20) {
                Text("Welcome")
                    .font(.system(size: 60, weight: .medium, design: .default))
                    .foregroundColor(.blue)
                    .offset(y: -170)
                TextField("Email", text: $email)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.black)
                            .bold()
                    }
                underLine()
                SecureField("Password", text: $password)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundColor(.black)
                            .bold()
                    }
                underLine()
                Button {
                    register()
                } label: {
                    Text("Register")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.blue)
                        )
                        .foregroundColor(.white)
                        .offset(y: 20)
                }
                Button {
                    login()
                } label: {
                    Text("Already have an account? Login")
                        .bold()
                        .foregroundColor(.black)
                }
                .padding(.top)
            }
            .frame(width: 350)
            .onAppear {
                Auth.auth().addStateDidChangeListener {
                    auth, user in if user != nil {
                        userIsLoggedIn.toggle()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct underLine: View {
    var body: some View {
        Rectangle()
            .frame(width: 350, height: 1)
            .foregroundColor(.black)
    }
}
