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
    }


}

// MARK: UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell else {
            fatalError("Invalid cell Identifier! Check `MovieRowCell` identifier function.")
        }
        return movieCell

    }
    
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

}
