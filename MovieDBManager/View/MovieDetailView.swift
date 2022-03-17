//
//  MovieDetailView.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 16.03.2022.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    let searchDetail : Bool
    
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error, dark:true) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!, id: movieId, searchDetail:searchDetail)
                
            }
        }
        .navigationBarTitle(movieDetailState.movie?.title ?? "")
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

struct MovieDetailListView: View {
    
    let movie: MovieDetail
    let id : Int
    let searchDetail : Bool
    let imageLoader = ImageLoader()
    @ObservedObject private var addFavoriteState = AddFavoriteState()
    @ObservedObject private var addWatchlistState = AddWatchlistState()
    
    var body: some View {
        let formattedFloat = String(format: "%.1f", movie.voteAverage)
        ZStack{
            VStack(spacing: 0) {
                List {
                    MovieDetailImage(imageLoader: imageLoader, imageURL: URL(string: String(format: "%@%@", "https://image.tmdb.org/t/p/w500/",movie.backdropPath))!, title: movie.originalTitle, points:formattedFloat, date: convertStringDateToStringDate(strDate: movie.releaseDate, inFormat: Constants.Date.serviceFormat, outFormat: Constants.Date.outFormat))
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    Text(movie.overview).padding(.top, 20)
                    
                }
                
                
            }
            if(searchDetail){
            VStack{
                Spacer()
                HStack{
                    Button("Watchlist") {
                        watchlist()
                    }
                    .foregroundColor(.white)
                    .frame(width: 100, height: 30)
                    .background(watchButtonColor)
                    .cornerRadius(5)
                    .disabled(addWatchlistState.addSuccess)
                    
                    Button("Favorite") {
                        favorite()
                    }
                    .foregroundColor(.white)
                    .frame(width: 100, height: 30)
                    .background(favButtonColor)
                    .cornerRadius(5)
                    .disabled(addFavoriteState.addSuccess)
                }.background(Color.white.opacity(0.0))
                    .padding(.bottom,15)
            }
        }
        }
        .alert(self.addWatchlistState.message, isPresented:$addWatchlistState.showAlert ) {
            Button("OK", role: .none) { }
        }
        .alert(self.addFavoriteState.message, isPresented:$addFavoriteState.showAlert ) {
            Button("OK", role: .none) { }
        }
    }
    var watchButtonColor: Color {
        return addWatchlistState.addSuccess ? .gray : Color(red: 1/255, green: 122 / 255, blue: 255 / 255)
    }
    var favButtonColor: Color {
        return addFavoriteState.addSuccess ? .gray : Color(red: 1/255, green: 122 / 255, blue: 255 / 255)
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
    let title : String
    let points: String
    let date: String
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
            VStack{
                Spacer()
                Text(title)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 380, alignment: .leading)
                    .padding(.leading,5)
                HStack{
                    Image("star")
                        .resizable()
                        .frame(width: 15, height: 15, alignment: .center)
                        .padding(.leading,5)
                    
                    Text(points)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text(date)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.white)
                        .padding(.trailing,40)
                }
                
            }.foregroundColor(Color.gray.opacity(0.3))
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
        
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        MovieDetailView(movieId: 1,searchDetail: false)
        
    }
}
