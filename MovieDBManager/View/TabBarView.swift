//
//  SwiftUIView.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 15.03.2022.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView{
            SearchView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Search")
                }
            WatchlistView()
                .tabItem{
                    Image(systemName: "bookmark")
                    Text("Watchlist")
                }
            FavoritesView()
                .tabItem{
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
