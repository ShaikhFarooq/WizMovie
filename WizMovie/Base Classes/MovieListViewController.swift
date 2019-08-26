//
//  MovieListViewController.swift
//  WizMovie
//
//  Created by Admin on 8/24/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!{
        didSet {
            mTableView.tableFooterView = UIView(frame: .zero)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpSearchBar()
    }

    func setUpSearchBar(){
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.placeholder = "Search by movie name"
        navigationItem.searchController?.searchBar.delegate = self
        self.definesPresentationContext = true
    }

}

// MARK: UISearchBar Delegate

extension MovieListViewController:  UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange imdbTitle:String) {
        print(imdbTitle)
    }

}

