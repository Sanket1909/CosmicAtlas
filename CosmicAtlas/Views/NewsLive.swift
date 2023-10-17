//
//  NewsLive.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-25.
//
import SwiftUI
import CachedAsyncImage

struct NewsLive: View {
    let title: String
    let imageURL: String
    let siteName: String
    let summary: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(siteName)")
                .foregroundColor(.blue)
                .italic()
            
            HStack(alignment: .center) {
                CachedAsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .easeInOut)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .transition(.opacity)
                    } else {
                        HStack {
                            
                        }
                    }
                }
            }
            Text(title)
                .font(.headline)
                .padding(8)
            
            Text(summary)
                .lineLimit(6)
                .font(.body)
                .padding(8)
        }
    }
    
}

struct NewsArticle_Previews: PreviewProvider {
    static var previews: some View {
        NewsLive(title: "Title", imageURL: "testurl", siteName: "Code Palace", summary: "A free way to learn how to code.")
    }
}





