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
    
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpSearchBar()
        fetchMovieList(movieTile: "bad")
    }
    
    
    // MARK: - Networking
    func fetchMovieList(movieTile: String){
        moviewViewModel.showLoader(windowView: view,tableView: mTableView)
        moviewViewModel.searchMovieWithTitle(movieTitle: movieTile){ [weak self] in
            DispatchQueue.main.async {
                self?.mTableView.reloadData()
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
        
        let cellViewModel = moviewViewModel.cellViewModel(index: indexPath.row)
        movieCell.viewModel = cellViewModel
        return movieCell
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
        delay(0.1, closure: {
            self.fetchMovieList(movieTile: imdbTitle)
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        moviewViewModel.hideLoader()
    }
}

