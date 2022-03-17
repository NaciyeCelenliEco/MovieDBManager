//
//  SearchView.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 15.03.2022.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var movieSearchState = SearchState()
    
    var body: some View {
        NavigationView {
            List {
                SearchBarView(placeholder: "Search movies", text: self.$movieSearchState.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                
                LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error, dark:true) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                
                if !self.movieSearchState.movies.isEmpty {
                    ForEach(self.movieSearchState.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id, searchDetail: true)) {
                            VStack(alignment: .leading) {
                                Text(movie.title)
                            }
                        }
                    }
                }
                
            }
            .onAppear {
                self.movieSearchState.startObserve()
            }
            .navigationBarTitle("Search",displayMode: .inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .previewDevice("iPhone 13")
    }
}
