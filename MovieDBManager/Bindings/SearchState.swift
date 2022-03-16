//
//  SearchState.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 16.03.2022.
//

import SwiftUI
import Combine
import Foundation

class SearchState: ObservableObject {
    
    @Published var query = ""
    @Published var movies: [Search.SearchResult] = []
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var subscriptionToken: AnyCancellable?
    
    
    var isEmptyResults: Bool {
        !self.query.isEmpty && self.movies.isEmpty
    }
    
    
    func startObserve() {
        guard subscriptionToken == nil else { return }

        self.subscriptionToken = self.$query
            .map { [weak self] text in
                self?.movies = []
                self?.error = nil
                return text

        }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.search(query: $0) }
    }
    
    func search(query: String) {
        self.movies = []

        self.isLoading = false

        guard !query.isEmpty else {
            return
        }
        self.isLoading = true
        let req = SearchRequest()

        AppRequestManager().get(.search(query: query), Search.self, req.toJSON()) { (data, error) in
            if let err = error {
                print(err)
            }else {
                self.isLoading = false
                if let result = data {
                    self.movies=result.results
                    print(self.movies.count)
                }
            }
        }
//        self.movieService.searchMovie(query: query) {[weak self] (result) in
//            guard let self = self, self.query == query else { return }
//
//            self.isLoading = false
//            switch result {
//            case .success(let response):
//                self.movies = response.results
//            case .failure(let error):
//                self.error = error as NSError
//            }
//        }
    }
    

}
