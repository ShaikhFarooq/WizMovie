//
//  FavoriteMovieCell.swift
//  WizMovie
//
//  Created by Admin on 8/31/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit

class FavoriteMovieCell: UITableViewCell {

    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var moviePosterImgView: UIImageView!
   
    // MARK: - Properties
    public static let reuseIdentifier = "favoriteMovieCell"
    
    public var viewModel: MovieDetailModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            movieNameLbl.text = "\(viewModel.name) (\(viewModel.movieYear))"
            let posterURL = viewModel.imageUrl
            moviePosterImgView.setImage(fromURL: URL(string: posterURL)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
