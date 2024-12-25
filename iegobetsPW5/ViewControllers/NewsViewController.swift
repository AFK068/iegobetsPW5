//
//  NewsViewController.swift
//  iegobetsPW5
//
//  Created by Ivan on 25.12.2024.
//

import UIKit

protocol NewsManagerDelegate: AnyObject {
    func didFetchNews(_ articles: [ArticleModel])
}

final class NewsViewController: UIViewController, NewsManagerDelegate, UITableViewDelegate {
    private var articles: [ArticleModel] = []
    var articleManager: ArticleManager?
    private let tableView: UITableView
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        self.tableView = UITableView()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        articleManager?.fetchNews()
    }
    
    // MARK: - TableView Setup
    private func setupTableView() {
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    // MARK: - NewsManagerDelegate
    func didFetchNews(_ articles: [ArticleModel]) {
        self.articles = articles
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = articles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.configure(with: article)
        return cell
    }
}
