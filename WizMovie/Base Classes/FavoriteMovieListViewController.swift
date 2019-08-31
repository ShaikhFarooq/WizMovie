//
//  FavoriteMovieListViewController.swift
//  WizMovie
//
//  Created by Admin on 8/24/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit

class FavoriteMovieListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var favMovieTableView: UITableView!{
        didSet {
            favMovieTableView.tableFooterView = UIView(frame: .zero)
        }
    }
    
    // MARK: - Injection
    let favMovieViewModel = FavoriteMovieViewModel()
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let favMovieArray = favMovieViewModel.getMoviesFromLocalStorage()
        favMovieViewModel.addErrorLable(windowView: view, tableView: favMovieTableView, message: noFavMovies)
        guard let favMovieArrays = favMovieArray else{ return }
        if favMovieArrays.count > 0{
            favMovieViewModel.hideErrorMessage()
            reloadData()
        }else{
            favMovieViewModel.showErrorMessage()
            reloadData()
        }
    }
    
    //MARK:- Relaod the tableview in order to refresh the list
    func reloadData(){
        DispatchQueue.main.async {
            self.favMovieTableView.reloadData()
        }
    }
}

// MARK: UITableView DataSource Methods
extension FavoriteMovieListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMovieViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favMovieCell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieCell.reuseIdentifier,
                                                            for: indexPath) as? FavoriteMovieCell else {
                                                                return UITableViewCell()
        }
        
        let cellViewModel = favMovieViewModel.getFavoriteCellViewModel(index: indexPath.row)
        favMovieCell.viewModel = cellViewModel
        return favMovieCell
    }
    
}

// MARK: UITableView Delegate Methods

extension FavoriteMovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
}
