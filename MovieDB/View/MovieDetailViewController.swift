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
    
//    lazy var collectionView: UICollectionView = {
//
//    }()
    
    var movieID: Int?
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
        }
    }
    
    func setupUI() {
        let contentView = UIView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [poster, movieTitle, releaseDate].forEach {
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
        
    }
    
}
