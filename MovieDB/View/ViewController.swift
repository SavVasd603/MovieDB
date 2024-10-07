//
//  ViewController.swift
//  MovieDB
//
//  Created by Amir Smagul on 03.10.2024.
//

import UIKit

class ViewController: UIViewController {

    lazy var movieDBLabel: UILabel = {
        let label = UILabel()
        label.text = "MovieDB"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupUI()
    }
    
    var movies: [Movie] = Array(repeating: Movie(), count: 9)
    
    func setupUI() {
        view.addSubview(movieTableView)
        view.addSubview(movieDBLabel)


        NSLayoutConstraint.activate([
            movieDBLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            movieDBLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 41),
            movieDBLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -41),
            
            movieTableView.topAnchor.constraint(equalTo: movieDBLabel.topAnchor, constant: 50),
            movieTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let movie = movies[indexPath.row]
        cell.imagePoster.image = movie.poster
        cell.title.text = movie.title
        return cell
    }
    
    
}

