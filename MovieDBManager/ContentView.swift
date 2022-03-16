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
        NavigationView{
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                if(!authState.loginSuccess){
                    VStack{
                        Text("The Movie Manager")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .bold()
                            .padding()
                        Spacer()
                        Text("Login with Email")
                            .font(.title)
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
        }
        .navigationBarHidden(true)
        .navigationBarTitle("")
    }
    
    func controlForm() -> Bool {
        if(email != "" && password != "")
        {
            return true
        }
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
