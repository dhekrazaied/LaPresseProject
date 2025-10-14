//
//  Article.swift
//  NGTest
//

import Foundation

struct Article: Codable {
    let id: String
    let channelName: String
    let title: String
    let publicationDate: Date
    let visuals: [Visual]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case channelName
        case title
        case publicationDate
        case visuals = "visual"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        channelName = try container.decode(String.self, forKey: .channelName)
        title = try container.decode(String.self, forKey: .title)
        publicationDate = DateFormatter.formatArticle.date(from: try container.decode(String.self, forKey: .publicationDate)) ?? Date()
        visuals = try container.decodeIfPresent(Array<Visual>.self, forKey: .visuals) ?? []
    }
}

struct Visual: Codable {
    let id: String
    let className: String
    let urlPattern: String
}
