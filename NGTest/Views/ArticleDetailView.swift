//
//  ArticleDetailView.swift
//  NGTest

import SwiftUI

struct ArticleDetailView: View {
    let article: ArticleViewData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if  let url = article.imageURL {
                    AsyncImage(url: url){
                        image in image.image?
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                
                Text(article.title)
                    .font(.title2)
                    .bold()
                
                Text("Publié le \(article.date)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Text("Catégorie : \(article.channelName)")
                    .font(.subheadline)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Détail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
