//
//  ArticlesOverViewController.swift
//  NGTest

import UIKit
import SwiftUI

class ArticlesOverViewController: UITableViewController  {
    
    private let viewModel = ArticleViewModel()
    private var isSortedDescending = true

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(HostingArticleViewCell.self, forCellReuseIdentifier: "HostingArticleViewCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let sortButton = UIBarButtonItem(title: "Trier", style: .plain, target: self, action: #selector(sortTapped))
        let filterButton = UIBarButtonItem(title: "Filtrer", style: .plain, target: self, action: #selector(filterTapped))
        navigationItem.rightBarButtonItems = [sortButton, filterButton]
    }

    @objc private func sortTapped() {
        isSortedDescending.toggle()
        viewModel.sortByDate(isSortedDescending)
        tableView.reloadData()
    }

    @objc private func filterTapped() {
        let alert = UIAlertController(title: "Filtrer par catégorie", message: nil, preferredStyle: .actionSheet)
        let channels = Set(viewModel.allArticles.map { $0.channelName }).sorted()

        for channel in channels {
            alert.addAction(UIAlertAction(title: channel, style: .default, handler: { _ in
                self.viewModel.filter(by: channel)
                self.tableView.reloadData()
            }))
        }

        alert.addAction(UIAlertAction(title: "Tous", style: .cancel, handler: { _ in
            self.viewModel.filter(by: "")
            self.tableView.reloadData()
        }))

        present(alert, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HostingArticleViewCell", for: indexPath) as? HostingArticleViewCell else {
            return UITableViewCell()
        }
        let article = viewModel.articles[indexPath.row]
        cell.configure(article: article)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.articles[indexPath.row]
        showArticleData(article)
    }

    private func showArticleData(_ article: ArticleViewData) {
        let detailVC = UIHostingController(rootView: ArticleDetailView(article: article))
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
