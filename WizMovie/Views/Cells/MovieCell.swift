//
//  MovieCell.swift
//  WizMovie
//
//  Created by Admin on 8/24/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var moviePosterImg: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    
    // MARK: - Properties
    public static let reuseIdentifier = "movieCell"
    
    public var viewModel: MovieTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            movieTitleLbl.text = "\(viewModel.name) (\(viewModel.movieYear))"
            let posterURL = viewModel.imageUrl
            moviePosterImg.setImage(fromURL: URL(string: posterURL)!)
        }
    }
    
    // MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
