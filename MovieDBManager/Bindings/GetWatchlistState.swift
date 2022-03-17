//
//  GetWatchlistState.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 16.03.2022.
//

import SwiftUI
import Combine
import Foundation

class GetWatchlistState: ObservableObject {
    
    @Published var isLoading = false
    @Published var error: String = ""
    @Published var items: [MovieListResult] = []
    @Published var showAlert = false

    func getList() {
        
        self.isLoading = true
        self.showAlert = false
        let req = WatchlistRequest()
       
        
        AppRequestManager().get(.getWatchlist(accountId: UserManager.accountId, sessionId: UserManager.sessionId), Watchlist.self, req.toJSON()) { (data, error) in
            self.isLoading = false
            
            if let err = error {
                self.error = "Failed to get watchlist"
                self.showAlert = true
                print(err)
            }else {
                if let result = data {
                    if(result.results.count == 0)
                    {
                        self.error = "Watchlist is empty"
                        self.showAlert = true
                    }
                    self.items=result.results
                   
                }
            }
        }
    }
}
