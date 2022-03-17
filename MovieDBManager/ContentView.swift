//
//  ContentView.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 15.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var authState = AuthState()

    var body: some View {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                if(!authState.loginSuccess){
                   
                    VStack{
                        Image("camera")
                            .resizable()
                            .frame(width: 120, height: 120, alignment: .center)
                            
                        Text("The Movie Manager")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .bold()
                            .padding()
                        Spacer()
                        if(authState.isLoading){
                            LoadingView(isLoading: self.authState.isLoading, error: self.authState.error, dark:false) {
                            }
                        }
                   
                        Text("Login with Email")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .bold()
                            .padding()
                        TextField("Email", text:$email)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                        SecureField("Password",text: $password)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                        Button("Login") {
                            authUser()
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.indigo)
                        .cornerRadius(10)
                        Spacer()
                    }

                }
            
                else{
                    TabBarView()
                }
            }
            .alert(self.authState.error, isPresented:$authState.showAlert ) {
                Button("OK", role: .cancel) { }
            }
    }
    
    func controlForm() -> Bool {
        if(email != "" && password != "")
        {
            return true
        }
        else if (email == "")
        {
            authState.error = "Enter email"
        }
        else if(password == "")
        {
            authState.error = "Enter password"
        }
     
        authState.showAlert = true
 
        return false
    }
    func authUser()
    {
        if(controlForm()){
        self.authState.fetchToken(email: self.email, password: self.password)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
