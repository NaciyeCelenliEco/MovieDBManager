//
//  LoadingView.swift
//  MovieDBManager
//
//  Created by Naciye Celenli on 16.03.2022.
//

import SwiftUI

struct LoadingView: View {
    
    let isLoading: Bool
    let error: String
    let dark : Bool
    let retryAction: (() -> ())?

    
    var body: some View {
        Group {
            if isLoading {
                    HStack {
                        Spacer()
                        ActivityIndicatorView(kind:dark)
                        Spacer()
                    }
                
            } else if error != "" {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text(error).font(.headline)
                        if self.retryAction != nil {
                            Button(action: self.retryAction!) {
                                Text("Retry")
                            }
                            .foregroundColor(Color.blue)
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true, error: "", dark: false, retryAction: nil)
    }
}
