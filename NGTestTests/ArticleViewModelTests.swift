
//
//  ArticleViewModelTests.swift
//  NGTestTests


import XCTest
@testable import NGTest

final class ArticleViewModelTests: XCTestCase {

    var viewModel: ArticleViewModel!

    override func setUp() async throws {
        try await super.setUp()
        await MainActor.run {
            viewModel = ArticleViewModel()
        }
        try await Task.sleep(nanoseconds: 200_000_000)
    }

    override func tearDown() async throws {
        await MainActor.run {
            viewModel = nil
        }
        try await super.tearDown()
    }

    func testLoadArticles() async {
        await MainActor.run {
            XCTAssertFalse(viewModel.allArticles.isEmpty, "allArticles sont presque toujours vides en test local")
            XCTAssertEqual(viewModel.allArticles.count, viewModel.articles.count, "articles et allArticles devraient avoir le même nombre d'éléments")
        }
    }

    func testFilterByChannelName() async {
        await MainActor.run {
            viewModel.filter(by: "Politique canadienne")
            XCTAssertTrue(viewModel.articles.allSatisfy { $0.channelName == "Politique canadienne" },
                          "All articles doivent appartenir au channel filtré")

            viewModel.filter(by: nil)
            XCTAssertEqual(viewModel.articles.count, viewModel.allArticles.count, "Filter avec nil devrait restaurer tous les articles")
        }
    }

    func testSortByDateDescending() async {
        await MainActor.run {
            viewModel.sortByDate(true)
            let sortedDates = viewModel.articles.map { $0.date }
            let expectedDates = sortedDates.sorted(by: >)
            XCTAssertEqual(sortedDates, expectedDates, "Articles doivent être triés par date décroissante")
        }
    }

    func testSortByDateAscending() async {
        await MainActor.run {
            viewModel.sortByDate(false)
            let sortedDates = viewModel.articles.map { $0.date }
            let expectedDates = sortedDates.sorted(by: <)
            XCTAssertEqual(sortedDates, expectedDates, "Articles doivent être triés par date croissante")
        }
    }
}
