//
//  FavoritesView.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 16.03.2022.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var getFavoriteState = GetFavoriteState()
    
    var body: some View {
        NavigationView {
            List {
                
                if self.getFavoriteState.items.isEmpty {
                    LoadingView(isLoading: self.getFavoriteState.isLoading, error: self.getFavoriteState.error , dark:true) {
                        self.getFavoriteState.getList()
                    }
                    
                }
                else{
                    ForEach(self.getFavoriteState.items) { movie in
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
            .navigationBarTitle("Favorites",displayMode: .inline)
        }
        .onAppear {
            self.getFavoriteState.getList()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .previewDevice("iPhone 13")
    }
}
