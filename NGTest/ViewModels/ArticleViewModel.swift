//
//  ArticleViewModel.swift
//  NGTest

import Foundation

@MainActor
class ArticleViewModel: ObservableObject {
    @Published var allArticles: [ArticleViewData] = []
    @Published var articles: [ArticleViewData] = []
    
    init() {
        loadArticles()
    }
    
    func loadArticles() {
        guard let url = Bundle.main.url(forResource: "articles", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode([Article].self, from: data)
                self.allArticles = decoded.map { ArticleViewData(article: $0) }
                articles = allArticles
            } catch {
                print("Error parsing JSON: \(error)")
            }
        } catch {
            print("Error reading data from URL: \(error)")
        }
    }
    
    func filter(by channelName: String?) {
        if let channelName = channelName, !channelName.isEmpty {
            articles = allArticles.filter { $0.channelName == channelName }
        } else {
            articles = allArticles
        }
    }
    
    func sortByDate(_ descending: Bool = true) {
        articles.sort { descending ? $0.date > $1.date : $0.date < $1.date}
    }
}
