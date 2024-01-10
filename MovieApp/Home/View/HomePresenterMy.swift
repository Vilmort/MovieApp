//
//  HomePresenterMy.swift
//  MovieApp
//
//  Created by Vanopr on 08.01.2024.
//

import Foundation
import KPNetwork

//MARK: - HomePresenterProtocol
protocol HomePresenterProtocolMy: AnyObject {
    func viewDidLoad()
    func viewDidDisappear()
    func didSelectReceipt(at indexPath: IndexPath)
}

//MARK: - HomePresenterDelegate
protocol HomePresenterDelegate: AnyObject {

}

final class HomePresenterMy: HomePresenterProtocolMy {
    weak var view: HomeVCProtocol?
    private let networkService: KPNetworkClient
    private var lists = [KPListSearchEntity.KPList]()
    private var genres = [KPMovieSearchEntity.KPSearchMovie]()
    private var selectedCategory: String?
    private var firstLoad = true
    
    var categories = ["All"]
    
    init(networkService: KPNetworkClient) {
        self.networkService = networkService
    }

    func viewDidLoad() {
        activate()
        activateGenresLoad()
    }
    
    func viewDidDisappear() {
        
    }
    
    func didSelectReceipt(at indexPath: IndexPath) {
        
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
    func activateGenresLoad(){
        view?.showLoading()
        Task{
            let result = await networkService.sendRequest(request: KPMovieSearchRequest())
            switch result{
            case .success(let response):
                genres = response.docs
                await updateGenres()
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
        view?.updateUI(lists: lists)
    }
    private func updateGenres() async{
        view?.updateGenres(genres: genres)
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
    
}
