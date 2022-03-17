//
//  AddWatchlistState.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 16.03.2022.
//

import SwiftUI
import Combine
import Foundation

class AddWatchlistState: ObservableObject {
    
    @Published var isLoading = false
    @Published var message: String = ""
    @Published var addSuccess : Bool = false
    @Published var showAlert : Bool = false
    
    init() {
        
    }
    
    func add(id: Int) {
        
        self.isLoading = true
        self.addSuccess = false
        let req = WatchlistRequest()
        req.mediaID = id
        req.mediaType = "movie"
        req.watchlist = true
        
        AppRequestManager().get(.addWatchlist(accountId: UserManager.accountId, sessionId: UserManager.sessionId), AddWatchlist.self, req.toJSON()) { (data, error) in
            self.isLoading = true
            if error != nil {
                
                self.message = "Adding movie to watchlist failed"
                self.showAlert = true
                
            }else {
                self.message = "Movie added to watchlist"
                self.addSuccess = true
                self.showAlert = true

            }
        }
    }
}



