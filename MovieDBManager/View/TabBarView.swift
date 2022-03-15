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
            Text("Home")
                    .tabItem{
                        Image(systemName: "house")
                        Text("Search")
                    }
            
            Text("Watchlist")
                .tabItem{
                    Image(systemName: "gear")
                    Text("Watchlist")
                }
            Text("Favorites")
                .tabItem{
                    Image(systemName: "gear")
                    Text("Favorites")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
