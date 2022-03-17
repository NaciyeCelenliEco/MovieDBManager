//
//  AuthState.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 15.03.2022.
//

import SwiftUI


class AuthState: ObservableObject {
    
    
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var isLoading: Bool = false
    @Published var loginSuccess: Bool = false
    @Published var showAlert : Bool = false
    @Published var error: String = ""

    init(){
        
    }
    func fetchToken(email: String, password: String){
        self.email = email
        self.password = password
        print(email)
        print(password)
        self.isLoading = true
        self.showAlert = false


        let req = TokenRequest()
        req.apiKey = Constants.Api.Key
        AppRequestManager().get(.token, Token.self, req.toJSON()) { (data, error) in
            self.isLoading = false
           
            if error != nil {
                self.error = "Get token failed"
                self.showAlert = true
            }else {
                if let result = data {
                    self.fetchLogin(requestToken: result.requestToken)
                }
            }
        }
    }
    
    
    func fetchLogin(requestToken: String){
        self.isLoading = true
        self.showAlert = false

        let req = LoginRequest()
        req.username = email
        req.password = password
        req.requestToken = requestToken
        AppRequestManager().get(.login, Login.self, req.toJSON()) { (data, error) in
            self.isLoading = false

            if error != nil {
                self.error = "Login failed, wrong credentials"
                self.showAlert = true

            }else {
                if let result = data {
                    self.createSession(requestToken: result.requestToken)
                }
            }
        }
    }
    
    func createSession(requestToken: String){
        self.isLoading = true
        self.showAlert = false
        let req = SessionRequest()
        req.requestToken = requestToken
        AppRequestManager().get(.createSession, CreateSession.self, req.toJSON()) { (data, error) in
            self.isLoading = false
            if error != nil  {
                self.error = "Create session failed"
                self.showAlert = true
            }else {
                if let result = data {
                    if(result.success)
                    {
                        self.getAccount(sessionId: result.sessionId)
                    }
                }
            }
        }
    }
    
    func getAccount(sessionId: String){
        self.isLoading = true
        self.showAlert = false

        let req = AccountRequest()
        AppRequestManager().get(.account(sessionId: sessionId), Account.self, req.toJSON()) { (data, error) in
            self.isLoading = false
            if error != nil {
                self.error = "Get account failed"
                self.showAlert = true
            }else {
                if let result = data {
                    print(result.id)
                    self.loginSuccess = true
                    
                    UserManager.accountId = result.id
                    UserManager.sessionId = sessionId
                    
                }
            }
        }
    }

}
