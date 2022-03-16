//
//  MovieDetailView.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 16.03.2022.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()

    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!, id: movieId)
                
            }
        }
        .navigationBarTitle(movieDetailState.movie?.title ?? "")
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

//struct MovieDetailListView: View {
//
//    let movie: MovieDetail?
//    @State private var selectedTrailer: MovieVideo?
//    let imageLoader = ImageLoader()
//
//    var body: some View {
//        List {
//            MovieDetailImage(imageLoader: imageLoader, imageURL: self.movie?.backdropPath)
//                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//
//            VStack {
//                Text(movie.voteAverage)
//                Text("·")
//                Text(movie.title)
//                Text(movie.overview)
//                Text(movie.releaseDate)
//                Text(movie.originalTitle)
//                Text(movie.backdropPath)
//
//            }
//
//            }
//
//
//        }
//
//    }

struct MovieDetailListView: View {
    
    let movie: MovieDetail
    let id : Int
    let imageLoader = ImageLoader()
    @ObservedObject private var addFavoriteState = AddFavoriteState()
    @ObservedObject private var addWatchlistState = AddWatchlistState()

    var body: some View {
        let formattedFloat = String(format: "%.1f", movie.voteAverage)
        VStack(spacing: 0) {
            List {
            MovieDetailImage(imageLoader: imageLoader, imageURL: URL(string: String(format: "%@%@", "https://image.tmdb.org/t/p/w500/",movie.backdropPath))!)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                HStack{
                    Text(movie.title)
                        .font(.headline)
                        .bold()
                        .padding()
                }
            HStack {
                Text(formattedFloat)
                Spacer()
               
                Text(convertStringDateToStringDate(strDate: movie.releaseDate, inFormat: Constants.Date.serviceFormat, outFormat: Constants.Date.outFormat))
            }
                Text(movie.overview)
                
            }
             Spacer()
            HStack{
                Button("Watch") {
                    watchlist()
                }
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color.indigo)
                .cornerRadius(5)
                .disabled(addWatchlistState.addSuccess)
                Button("Fav") {
                   favorite()
                }
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color.indigo)
                .cornerRadius(5)
                .disabled(addFavoriteState.addSuccess)
            }.background(Color.white.opacity(0.0))
        }
        
        
       
        
    }
    func watchlist(){
        addWatchlistState.add(id: id)
    }
    func favorite(){
        addFavoriteState.add(id: id)
    }
    func convertStringDateToStringDate(strDate: String, inFormat: String, outFormat: String) -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = inFormat;
        let date = dateFormatter.date(from: strDate);
        dateFormatter.dateFormat = outFormat;
        
        if date != nil {
            return dateFormatter.string(from: date!);
        } else {
            return strDate
        }
    }
}
struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: 1)
        }
    }
}
