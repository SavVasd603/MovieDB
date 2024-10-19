//
//  NetworkManager.swift
//  MovieDB
//
//  Created by Amir Smagul on 09.10.2024.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let apiKey = "12e319ca82685218a33a0b2e917d6d11"
    private let urlString = "https://api.themoviedb.org"
    private let urlImageString = "https://image.tmdb.org/t/p/w500"
    private let session = URLSession(configuration: .default)
    
    private lazy var urlComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        return urlComponents
    }()
    
    func loadMovie(complition: @escaping (Movie) -> ()) {
        urlComponents.path = "/3/movie/now_playing"
        guard let url = urlComponents.url else { return }
        DispatchQueue.global().async {
            let task = self.session.dataTask(with: url) { data, _, error in
                if let error {
                    print(error)
                }
                guard let data else { return }
                if let movies = try? JSONDecoder().decode(Movie.self, from: data) {
                    DispatchQueue.main.async {
                        complition(movies)
                    }
                }
            }
            task.resume()
        }
    }
    
    func loadImage(posterPath: String, complition: @escaping (UIImage) -> ()) {
        let urlString = urlImageString + posterPath
        guard let url = URL(string: urlString) else {return}
        DispatchQueue.global().async {
            let task = self.session.dataTask(with: url) { data, _, error in
                if let error {
                    print(error)
                }
                guard let data else { return }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                            complition(image)
                    }
                }
            }
            task.resume()
        }
    }
    
    func loadDetail(movieId: Int, complition: @escaping (MovieDetail)->()) {
        urlComponents.path = "/3/movie/\(movieId)"
        guard let url = urlComponents.url else {return}
        DispatchQueue.global().async {
            let task = self.session.dataTask(with: url) { data, response, error in
                if let error = error {
                    return print(error)
                }
                
                guard let data else {return}
                if let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data) {
                    DispatchQueue.main.async {
                        complition(movieDetail)
                    }
                }
            }
            task.resume()
        }
    }
    
}
