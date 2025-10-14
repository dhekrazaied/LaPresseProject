//
//  ArticleCellView.swift
//  NGTest
import SwiftUI

struct ArticleCellView: View {
    let article: ArticleViewData
    
    var body: some View {
        HStack(spacing: 12) {
            if  let url = article.imageURL {
                AsyncImage(url: url){
                    image in image.image?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title)
                    .font(.headline)
                Text(article.channelName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(article.publicationDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
