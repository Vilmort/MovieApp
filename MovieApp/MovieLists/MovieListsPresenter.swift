//
//  MovieListsPresenter.swift
//  MovieApp
//
//  Created by Victor on 26.12.2023.
//

import Foundation
import KPNetwork

final class MovieListsPresenter: MovieListsPresenterProtocol {
    weak var view: MovieListsViewProtocol?
    var router: MovieListsRouter!
    
    private let networkService: KPNetworkClient
    private var lists = [KPListSearchEntity.KPList]()
    private var selectedCategory: String?
    private var firstLoad = true
    
    init(networkService: KPNetworkClient) {
        self.networkService = networkService
    }
    
    func activate() {
        view?.showLoading()
        Task {
            let result = await networkService.sendRequest(request: KPListSearchRequest())
            switch result {
            case let .success(response):
                lists = response.docs
                await updateUI()
            case .failure:
                await showError()
            }
            await MainActor.run {
                view?.hideLoading()
            }
        }
    }
    
    @MainActor
    private func updateUI() async {
        var lists = self.lists.filter { $0.category != "0" }
        let categories = ["All"] + Array(Set(lists.compactMap { $0.category })).sorted()
        if let selectedCategory {
            lists = lists.filter { $0.category == selectedCategory }
        }
        view?.update(
            with: .init(
                categories: categories.map {
                    category in
                    
                    return .init(
                        title: category,
                        didSelectHandler: {
                            [weak self] in
                            
                            self?.didSelectCategory(category)
                        }
                    )
                },
                lists: lists.map {
                    list in
                    
                    return .init(
                        list: .init(
                            name: list.name ?? "",
                            imageURL: URL(string: list.cover?.url ?? "")
                        ),
                        didSelect: {
                            [weak self] in
                            
                            self?.didSelectList(title: list.name, slug: list.slug)
                        }
                    )
                },
                updateCategories: firstLoad
            )
        )
        firstLoad = false
    }
    
    @MainActor
    func showError() async {
        view?.showError(
            "Произошла ошибка",
            message: "Попробуйте еще раз",
            actionTitle: "Обновить",
            action: {
                [weak self] view in
                
                view.removeFromSuperview()
                self?.activate()
            })
    }
    
    private func didSelectList(title: String?, slug: String?) {
        guard let title, let slug else {
            return
        }
        router.showMovieList(title: title, slug: slug)
    }
    
    private func didSelectCategory(_ category: String) {
        selectedCategory = category == "All" ? nil : category
        Task {
            await updateUI()
        }
    }
}
