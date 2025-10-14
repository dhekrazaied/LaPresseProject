//
//  ArticleViewData.swift
//  NGTest
import Foundation

struct ArticleViewData: Identifiable {
    let id: String
    let channelName: String
    let title: String
    let publicationDate: String
    let imageURL: URL?
    let date: Date

    init(article: Article) {
        self.id = article.id
        self.channelName = article.channelName
        self.title = article.title
        self.publicationDate = DateFormatter.DisplayDate.string(from: article.publicationDate)
        self.imageURL = URL(string:article.visuals.first?.urlPattern ?? "")
        self.date = article.publicationDate
    }
}
