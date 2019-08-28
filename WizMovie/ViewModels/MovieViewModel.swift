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
    let loaderWithText = LoaderWithText(text: "\(UIMessages.loadingMessage)")
    let errorMessageLabel = ErrorMessage(text: "")
    var movieTable = UITableView()
    var view = UIView()
    
    // MARK: - Constructor
    init(network: Network) {
        self.network = network
    }
    
    // MARK: Messages
    public enum UIMessages {
        static let loadingMessage: String = "Please Wait...."
        static let searchMessage: String = "Search your favorite movies in THE MOVIE DB"
        static let notFound: String = "No results found for "
        static let networkError: String = "Oops, there was an error fetching data :(\nPlease, check your connection and try again."
    }
    
    // MARK: - Network call
    func searchMovieWithTitle(movieTitle: String,completion:(() -> Void)?) {
        if NetworkConnection.isConnectedToNetwork(){
            if !movieTitle.isEmpty{
                loaderWithText.show()
                loaderWithText.text = "\(UIMessages.loadingMessage)"
                guard let movTitle =         movieTitle.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)else{
                    return
                }
                let url: String = "\(EndPoints.Search.path)\(movTitle)\(APIKey.ApiKey.rawValue)"
                print(url)
                
                network?.searchMoviesOnJson(urlByName: url,type: Movies.self) {[weak self] (response,success,error) in
                    if let responseData = response{
                        self?.movies = responseData
                        print(self?.movies?.Search)
                        self?.loaderWithText.hide()
                        self?.movieTable.isHidden = false
                        self?.errorMessageLabel.hide()
                        completion?()
                    }
                    else if let error = error {
                        print(error)
                        self?.loaderWithText.hide()
                        self?.movieTable.isHidden = true
                        self?.errorMessageLabel.text = "\(UIMessages.notFound)\(movieTitle)"
                        self?.errorMessageLabel.show()
                    }
                }
            }else{
                errorMessageLabel.text = "\(UIMessages.searchMessage)"
                errorMessageLabel.show()
            }
        }else{
            errorMessageLabel.text = "\(UIMessages.networkError)"
            errorMessageLabel.show()
        }
        
    }
    
    func fetchMovieDetailsWithTitle(movieTitle: String) {
        let url: String = "\(EndPoints.Title.path)\(movieTitle)\(APIKey.ApiKey.rawValue)"
        print(url)
        
    }
    
    public func showLoader(windowView: UIView,tableView: UITableView){
        view = windowView
        movieTable = tableView
        view.addSubview(loaderWithText)
        view.addSubview(errorMessageLabel)
        errorMessageLabel.hide()
    }
    
    public func hideLoader(){
        loaderWithText.hide()
        errorMessageLabel.hide()
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
