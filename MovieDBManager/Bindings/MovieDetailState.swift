//
//  MovieDetailState.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 16.03.2022.
//

import SwiftUI

class MovieDetailState: ObservableObject {
    
    @Published var movie: MovieDetail?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init() {

    }
    
    func loadMovie(id: Int) {
        
        self.isLoading = false
        let req = RequestObj()
        AppRequestManager().get(.movieDetail(movieId: id), MovieDetail.self, req.toJSON()) { (data, error) in
            self.isLoading = true
            if let err = error {
                print(err)
            }else {
                if let result = data {
                    self.movie = result
                    
                }
            }
        }
        
    }
}

