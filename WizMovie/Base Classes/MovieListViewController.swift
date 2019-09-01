//
//  MovieListViewController.swift
//  WizMovie
//
//  Created by Admin on 8/24/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mTableView: UITableView!{
        didSet {
            mTableView.tableFooterView = UIView(frame: .zero)
        }
    }
    
    // MARK: - Injection
    let moviewViewModel = MovieViewModel(network: Network())
    var imdbTitle = ""
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpSearchBar()
        fetchMovieList(movieTile: "bad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.reloadData()
    }
    
    // MARK: - Networking
    func fetchMovieList(movieTile: String){
        moviewViewModel.showLoader(windowView: view,tableView: mTableView)
        moviewViewModel.searchMovieWithTitle(movieTitle: movieTile){ [weak self] in
            self?.reloadData()
        }
    }
    
    func fetchMovieWithTitle(movieName: String,completion:((_ movie: MovieDetailModel) -> Void)?){
        moviewViewModel.fetchMovieDetailsWithTitle(movieTitle: movieName){ [weak self] in
            DispatchQueue.main.async {
                if let detail = self?.moviewViewModel.getMovieDetails(){
                    completion?(detail)
                }
            }
        }
    }
    
    // MARK: - Search Settings
    func setUpSearchBar(){
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.searchController?.searchBar.sizeToFit()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.placeholder = "Search by movie name"
        navigationItem.searchController?.searchBar.delegate = self
        self.definesPresentationContext = true
    }
    
    //MARK:- Relaod the tableview in order to refresh the list
    func reloadData(){
        DispatchQueue.main.async {
            self.mTableView.reloadData()
        }
    }
}

// MARK: UITableView DataSource Methods
extension MovieListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviewViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier,
                                                            for: indexPath) as? MovieCell else {
                                                                return UITableViewCell()
        }
        
        let cellViewModel = moviewViewModel.getCellViewModel(index: indexPath.row)
        movieCell.viewModel = cellViewModel
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = moviewViewModel.getCellViewModel(index: indexPath.row)
        if let movieName = vm?.name{
            fetchMovieWithTitle(movieName: movieName){  [weak self] (movieDetail) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let movieDetailViewController = storyBoard.instantiateViewController(withIdentifier: "movieDetailViewController") as! MovieDetailViewController
                movieDetailViewController.viewModel = movieDetail
                self?.navigationController?.pushViewController(movieDetailViewController, animated: true)
            }
            
        }
    }
}

// MARK: UITableView Delegate Methods
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

// MARK: SearchBar Delegate Methods
extension MovieListViewController:  UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange imdbTitle:String) {
        self.imdbTitle = imdbTitle
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if self.imdbTitle.count > 0{
            searchBar.resignFirstResponder()
            self.fetchMovieList(movieTile: self.imdbTitle)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.imdbTitle = ""
        moviewViewModel.hideLoader()
    }
}

