//
//  NewPage.swift
//  iegobetsPW5
//
//  Created by Ivan on 25.12.2024.
//

import Foundation

// MARK: - NewPage
struct NewsPage: Decodable {
    var news: [ArticleModel]?
    var requestId: String?
    mutating func passTheRequestId() {
        for i in 0..<(news?.count ?? 0) {
            news?[i].requestId = requestId
        }
    }
}
