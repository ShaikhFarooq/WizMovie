//
//  MovieDetailViewController.swift
//  WizMovie
//
//  Created by Admin on 8/29/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieYearLbl: UILabel!
    @IBOutlet weak var movieDirectorLbl: UILabel!
    @IBOutlet weak var movieActorLbl: UILabel!
    @IBOutlet weak var moviePosterImgView: UIImageView!
    @IBOutlet weak var imdbRatingLbl: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    //MARK: Properties
    public var viewModel: MovieDetailModel?
    var favBtnIsSelected = false
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let vm = viewModel else {
            return
        }
        self.navigationItem.title = vm.name
        movieNameLbl.text = vm.name
        movieYearLbl.text = "Year : \(vm.movieYear)"
        movieDirectorLbl.text = "Director : \(vm.director)"
        movieActorLbl.text = "Actor : \(vm.actor)"
        imdbRatingLbl.text = "Rated : \(vm.imdbRating)"
        moviePosterImgView.setImage(fromURL: URL(string: vm.imageUrl)!)
    }
    @IBAction func favoriteBtnTapped(_ sender: Any) {
        favBtnIsSelected = !favBtnIsSelected
        if favBtnIsSelected == true {
            favoriteBtn.setImage(#imageLiteral(resourceName: "favIcon"), for: .normal)
        } else if favBtnIsSelected == false {
            favoriteBtn.setImage(#imageLiteral(resourceName: "unfavIcon"), for: .normal)
        }
    }
}
