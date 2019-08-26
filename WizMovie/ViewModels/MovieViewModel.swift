//
//  MovieViewModel.swift
//  WizMovie
//
//  Created by Admin on 8/25/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation


class MovieViewModel{
    
    private var network: Network?
    private var movies: Movies?

    // MARK: - Constructor
    init(network: Network) {
        self.network = network
    }
    
    // MARK: - Network call
    func searchMovieWithTitle(movieTitle: String,completion: (() -> Void)?) {
        let url: String = "\(EndPoints.Search.path)\(movieTitle)\(APIKey.ApiKey.rawValue)"
        print(url)
        network?.searchMoviesOnJson(urlByName: url,type: Movies.self) { (response,success,error) in
            if let responseData = response{
                self.movies = responseData
                print(self.movies?.Search)
                completion?()
            }
            else if let error = error {
                print(error)
            }
        }
    }
    
    func fetchMovieDetailsWithTitle(movieTitle: String) {
        let url: String = "\(EndPoints.Title.path)\(movieTitle)\(APIKey.ApiKey.rawValue)"
        print(url)
        
    }
    
    public func cellViewModel(index: Int) -> MovieTableViewCellModel? {
        guard let movies = movies else { return nil }
        let movieTableViewCellModel = MovieTableViewCellModel(movie: (movies.Search[index]))
        return movieTableViewCellModel
    }
    
    public var count: Int {
        return movies?.Search.count ?? 0
    }
}
