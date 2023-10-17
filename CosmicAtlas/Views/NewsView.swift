//
//  NewsView.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-25.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var data : SpaceAPI
    @Environment(\.openURL) var openURL
    private var textWidth = 300.0
    
    var body: some View {
        List {
            ForEach(data.news) { news in
                NewsLive(
                    title: news.title,
                    imageURL: news.imageUrl, siteName: news.newsSite, summary: news.summary)
                .onTapGesture {
                    openURL(URL(string: news.url)!)
                }
            }
        }
        .refreshable {
            data.getData()
        }
    }
    
    struct NewsView_Previews: PreviewProvider {
        static var previews: some View {
            NewsView()
                .environmentObject(SpaceAPI())
        }
    }
}
