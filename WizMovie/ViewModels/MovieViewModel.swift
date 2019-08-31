//
//  MovieViewModel.swift
//  WizMovie
//
//  Created by Admin on 8/25/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation
import UIKit

class MovieViewModel{
    
    // MARK: Properties
    private var network: Network?
    private var movies: Movies?
    private var movieDetails: MovieDetails?
    let loaderWithText = LoaderWithText(text: "\(loadingMessage)")
    let errorMessageLabel = ErrorMessage(text: "")
    var movieTable = UITableView()
    var view = UIView()
    
    // MARK: - Constructor
    init(network: Network) {
        self.network = network
    }
    
    // MARK: Messages
//    public enum UIMessages {
//        static let loadingMessage: String = "Please wait...."
//        static let searchMessage: String = "Search your favorite movies."
//        static let notFound: String = "No Movies Found for "
//        static let networkError: String = "Network Error”, “Unable to contact the server."
//    }
    
    // MARK: - Network call
    func searchMovieWithTitle(movieTitle: String,completion:(() -> Void)?) {
        if NetworkConnection.isConnectedToNetwork(){
            if !movieTitle.isEmpty{
                loaderWithText.show()
                loaderWithText.text = "\(loadingMessage)"
                guard let movTitle =         movieTitle.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)else{
                    return
                }
                let url: String = "\(EndPoints.Search.path)\(movTitle)\(APIKey.ApiKey.rawValue)"
                print(url)
                
                network?.searchMoviesOnJson(urlByName: url,type: Movies.self) {[weak self] (response,success,error) in
                    if let responseData = response{
                        self?.movies = responseData
                        self?.loaderWithText.hide()
                        self?.movieTable.isHidden = false
                        self?.errorMessageLabel.hide()
                        completion?()
                        
                    }else if let error = error {
                        print(error)
                        self?.loaderWithText.hide()
                        self?.movieTable.isHidden = true
                        self?.errorMessageLabel.text = "\(noMovieFound)\(movieTitle)"
                        self?.errorMessageLabel.show()
                    }
                }
            }else{
                errorMessageLabel.text = "\(searchMessage)"
                errorMessageLabel.show()
            }
        }else{
            errorMessageLabel.text = "\(networkError)"
            errorMessageLabel.show()
        }
        
    }
    
    func fetchMovieDetailsWithTitle(movieTitle: String,completion:(() -> Void)?) {
        if NetworkConnection.isConnectedToNetwork(){
            if !movieTitle.isEmpty{
                guard let movTitle =         movieTitle.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)else{
                    return
                }
                let url: String = "\(EndPoints.Title.path)\(movTitle)\(APIKey.ApiKey.rawValue)"
                print(url)
                loaderWithText.show()
                network?.searchMoviesOnJson(urlByName: url,type: MovieDetails.self) {[weak self] (response,success,error) in
                    if let responseData = response{
                        self?.loaderWithText.hide()
                        self?.movieDetails = responseData
                        completion?()
                    }else if let error = error {
                        self?.loaderWithText.hide()
                        print(error)
                    }
                }
            }else{
                errorMessageLabel.text = "\(searchMessage)"
                errorMessageLabel.show()
            }
            
        }else{
            errorMessageLabel.text = "\(networkError)"
            errorMessageLabel.show()
        }
    }
    
    // MARK: - To add loaders
    public func showLoader(windowView: UIView,tableView: UITableView){
        view = windowView
        movieTable = tableView
        view.addSubview(loaderWithText)
        view.addSubview(errorMessageLabel)
        loaderWithText.hide()
        errorMessageLabel.hide()
    }
    
    // MARK: - Hide loaders
    public func hideLoader(){
        loaderWithText.hide()
        errorMessageLabel.hide()
    }
    
    // MARK: - To send each cell data using index
    public func getCellViewModel(index: Int) -> MovieTableViewCellModel? {
        guard let movies = movies else { return nil }
        let movieTableViewCellModel = MovieTableViewCellModel(movie: (movies.Search[index]))
        return movieTableViewCellModel
    }
    
    // MARK: - Get each movie details
    public func getMovieDetails() -> MovieDetailModel?{
        guard let movieDetail = movieDetails else { return nil }
        let movieDetailModel = MovieDetailModel(movieDetail: movieDetail)
        return movieDetailModel
    }
    
    // MARK: - Number of movies to be shown
    public var count: Int {
        return movies?.Search.count ?? 0
    }
}
