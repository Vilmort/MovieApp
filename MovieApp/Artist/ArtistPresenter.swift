//
//  ArtistPresenter.swift
//  MovieApp
//
//  Created by Victor on 12.01.2024.
//

import Foundation
import KPNetwork

final class ArtistPresenter: ArtistPresenterProtocol {
    weak var view: ArtistViewProtocol?
    var router: ArtistRouterProtocol?
    
    private let networkService: KPNetworkClient
    private let id: Int
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        return df
    }()
    
    init(id: Int, networkService: KPNetworkClient = DIContainer.shared.networkService) {
        self.networkService = networkService
        self.id = id
    }
    
    func activate() {
        Task {
            await loadData()
        }
    }
    
    @MainActor
    func loadData() async {
        view?.showLoading()
        let result = await networkService.sendRequest(request: KPArtistRequest(id: id))
        view?.hideLoading()
        switch result {
        case .success(let model):
            let name: String = {
                if let name = model.name, !name.isEmpty {
                    return name
                } else {
                    return model.enName ?? ""
                }
            }()
            
            view?.update(
                with: .init(
                    name: name,
                    imageURL: URL(string: model.photo ?? ""),
                    moviesCount: model.movies?.count,
                    profession: model.profession?.compactMap { $0.value }.joined(separator: ", ").capitalized,
                    birthPlace: model.birthPlace?.compactMap { $0.value }.joined(separator: ", "),
                    age: model.age,
                    growth: model.growth,
                    death: dateFormatter.date(from: model.death ?? ""),
                    birthday: dateFormatter.date(from: model.birthday ?? "")
                )
            )
        case .failure:
            view?.showError(
                "Не получилось загрузить информацию об артисте",
                message: "Попробуйте еще раз",
                actionTitle: "Обновить",
                action: {
                    [weak self] stub in
                    
                    stub.removeFromSuperview()
                    Task {
                        await self?.loadData()
                    }
                }
            )
        }
    }
}
