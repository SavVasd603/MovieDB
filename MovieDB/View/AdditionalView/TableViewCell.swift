//
//  TableViewCell.swift
//  MovieDB
//
//  Created by Amir Smagul on 04.10.2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    lazy var imagePoster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        
        return image
    }()
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imagePoster, title])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(imagePoster)
        stackView.addArrangedSubview(title)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo:
                contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
//            imagePoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        ])
        
    }
    
}
