//
//  HostingArticleViewCell.swift
//  NGTest

import UIKit
import SwiftUI

class HostingArticleViewCell: UITableViewCell {
    
    private var hostingController: UIHostingController<ArticleCellView>?
    
    func configure(article: ArticleViewData) {
        if let hostingController = hostingController {
            hostingController.rootView = ArticleCellView(article: article)
        } else {
            let hostingController = UIHostingController(rootView: ArticleCellView(article: article))
            self.hostingController = hostingController
            hostingController.view.backgroundColor = .clear

            contentView.addSubview(hostingController.view)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
}
