//
//  WatchlistView.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 16.03.2022.
//

import SwiftUI

struct WatchlistView: View {
    @ObservedObject var getWatchlistState = GetWatchlistState()
    
    var body: some View {
        NavigationView {
            List {
                
                if self.getWatchlistState.items.isEmpty {
                    LoadingView(isLoading: self.getWatchlistState.isLoading, error: self.getWatchlistState.error, dark:true) {
                        self.getWatchlistState.getList()
                    }
                    
                }
                else{
                    ForEach(self.getWatchlistState.items) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id, searchDetail: false)) {
                            VStack(alignment: .leading) {
                                HStack(){
                                    MovieCellImage(imageLoader: ImageLoader(), imageURL: URL(string: String(format: "%@%@", "https://image.tmdb.org/t/p/w500/",movie.posterPath))!)
                                    Text(movie.originalTitle)
                                }
                                
                            }
                        }
                    }
                }
                
            }
            .navigationBarTitle("Watchlist",displayMode: .inline)
        }
        .onAppear {
            self.getWatchlistState.getList()
        }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
            .previewDevice("iPhone 13")
    }
}
