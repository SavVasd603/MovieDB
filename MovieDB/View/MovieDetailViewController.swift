//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Amir Smagul on 16.10.2024.
//

import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var releaseDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15 , weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false // Отключаем горизонтальный индикатор
        collectionView.showsVerticalScrollIndicator = false // Отключаем вертикальный индикатор
        return collectionView
    }()

    
    var movieID: Int?
    var genres: [Genre] = []
    private var movieDetail: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        apiCall()
    }
    
    func apiCall() {
        guard let movieID else { return }
        NetworkManager().loadDetail(movieId: movieID) { result in
            self.movieDetail = result
            
            guard let movieDetail = self.movieDetail else { return }
            NetworkManager().loadImage(posterPath: movieDetail.posterPath!) { UIImage in
                self.poster.image = UIImage
            }
            
            self.movieTitle.text = movieDetail.title
            if let releaseDate = movieDetail.releaseDate {
                let year = releaseDate.prefix(4)
                self.releaseDate.text = "Release date: \(year) "
            }
            
            if let genres = movieDetail.genres {
                self.genres = genres
                self.collectionView.reloadData()
            }
        }
    }
    
    func setupUI() {
        let contentView = UIView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [poster, movieTitle, releaseDate, collectionView].forEach {
            scrollView.addSubview($0)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.safeAreaLayoutGuide)
        }

        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        poster.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(424)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(15)
        }
        
        collectionView.snp.makeConstraints { make in
                make.top.equalTo(releaseDate.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview().inset(10)
                make.height.equalTo(40) // Привязываем фиксированную высоту
                make.bottom.equalToSuperview() // Завершаем contentView этим элементом
            }
    }
}

extension MovieDetailViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else {
            fatalError("Unable to dequeue GenreCell")
        }
        let genre = genres[indexPath.item]
        cell.configure(with: genre) // Настраиваем ячейку с жанром
        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let genre = genres[indexPath.item]
        let padding: CGFloat = 16 // Отступы по бокам

        // Вычисляем ширину текста с учётом шрифта
        let font = UIFont.systemFont(ofSize: 14, weight: .medium)
        let textWidth = genre.name!.size(withAttributes: [.font: font]).width

        // Ограничиваем минимальную и максимальную ширину ячейки
        let width = min(max(textWidth + padding, 60), collectionView.frame.width - 32)

        return CGSize(width: width, height: 40)
    }
}

