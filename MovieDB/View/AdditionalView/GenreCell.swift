//
//  GenreCell.swift
//  MovieDB
//
//  Created by Amir Smagul on 17.10.2024.
//

import UIKit

class GenreCell: UICollectionViewCell {
    static let identifier = "GenreCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true // Сжатие шрифта, если текст не влезает
        label.minimumScaleFactor = 0.8 // Минимальный размер шрифта — 80% от исходного
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true

        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8) // Отступы внутри ячейки
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with genre: Genre) {
        nameLabel.text = genre.name
    }
}

