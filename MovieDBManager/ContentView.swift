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
    @State private var showingLoginScreen =  true

    var body: some View {
        NavigationView{
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                if(showingLoginScreen){
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
                            authUser(username: email, password: password)
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.indigo)
                        .cornerRadius(10)
                        Spacer()
                    }

                }
            
                else{
                    //Tabbar
                }
            }
        }
        .navigationBarHidden(true)
    }
    func authUser(username: String, password: String)
    {
        
       showingLoginScreen = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
