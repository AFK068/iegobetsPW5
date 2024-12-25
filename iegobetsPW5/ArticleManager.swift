//
//  ArticleManager.swift
//  iegobetsPW5
//
//  Created by Ivan on 25.12.2024.
//

import Foundation

final class ArticleManager {
    private let decoder: JSONDecoder = JSONDecoder()
    private weak var delegate: NewsManagerDelegate?
    
    init(delegate: NewsManagerDelegate) {
        self.delegate = delegate
    }
    
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }
    
    func fetchNews() {
        guard let url = getURL(4, 1) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return } 

            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let newsPage = try self.decoder.decode(NewsPage.self, from: data)
                let articles = newsPage.news ?? []
                self.delegate?.didFetchNews(articles)
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}
