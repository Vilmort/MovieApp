//
//  ArtistController.swift
//  MovieApp
//
//  Created by Victor on 12.01.2024.
//

import UIKit

final class ArtistController: ViewController, ArtistViewProtocol {
    var presenter: ArtistPresenterProtocol!
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let infoLabel = UILabel()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 6
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        presenter.activate()
    }
    
    func update(with model: Model) {
        imageView.update(
            with: .init(
                image: nil,
                url: model.imageURL,
                tintColor: nil,
                cornerRadius: 16
            )
        )
        nameLabel.update(
            with: .init(
                text: model.name,
                font: .montserratSemiBold(ofSize: 24),
                textColor: .white,
                numberOfLines: 0,
                alignment: .center
            )
        )
        infoLabel.update(
            with: .init(text: infoString(model), numberOfLines: 0, textAlignment: .center)
        )
    }
    
    private func configure() {
        view.backgroundColor = .appSoft
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
            $0.width.equalToSuperview().offset(-32)
        }
        
        stackView.addArrangedSubview(imageView)
        stackView.setCustomSpacing(16, after: imageView)
        imageView.snp.makeConstraints {
            $0.width.equalTo(scrollView).multipliedBy(0.4)
            $0.height.equalTo(imageView.snp.width).multipliedBy(1.45)
        }
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(infoLabel)
    }
    
    private func infoString(_ model: Model) -> NSAttributedString {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.YYYY"
        
        var result = ""
        if let profession = model.profession {
            result += profession + "\n"
        }
        if let moviesCount = model.moviesCount {
            result += "Проектов: \(moviesCount)\n"
        }
        if let birthday = model.birthday {
            result += df.string(from: birthday)
        }
        if let death = model.death {
            result += " - " + df.string(from: death) + "\n"
        } else {
            result += "\n"
        }
        if let age = model.age {
            result += "Возраст: \(age)\n"
        }
        if let growth = model.growth {
            result += "Рост: \(growth) см."
        }
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 6
        return NSAttributedString(
            string: result,
            attributes: [
                .font: UIFont.montserratMedium(ofSize: 18),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraph
            ]
        )
    }
    
}

extension ArtistController {
    struct Model {
        let name: String
        let imageURL: URL?
        let moviesCount: Int?
        let profession: String?
        let birthPlace: String?
        let age: Int?
        let growth: Int?
        let death: Date?
        let birthday: Date?
    }
}
