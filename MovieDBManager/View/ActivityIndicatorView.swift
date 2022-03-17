//
//  ActivityIndicatorView.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 16.03.2022.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    var darkColor : Bool = false
    init(kind:Bool){
        self.darkColor = kind
        
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        if(!darkColor){
            view.color = .white
        }

        view.startAnimating()
        return view
    }
}
