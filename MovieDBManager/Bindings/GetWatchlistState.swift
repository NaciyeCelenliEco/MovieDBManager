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

    func getList() {
        
        self.isLoading = true
       
        let req = WatchlistRequest()
       
        
        AppRequestManager().get(.getWatchlist(accountId: UserManager.accountId, sessionId: UserManager.sessionId), Watchlist.self, req.toJSON()) { (data, error) in
            self.isLoading = true
            if let err = error {
                print(err)
            }else {
                if let result = data {
                    self.items=result.results
                   
                }
            }
        }
    }
}
