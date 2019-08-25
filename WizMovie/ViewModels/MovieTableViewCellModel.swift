//
//  MovieTableViewCellModel.swift
//  WizMovie
//
//  Created by Admin on 8/25/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

class MovieTableViewCellModel {
    
    private let movie: Search
    
    init(movie: Search) {
        self.movie = movie
    }
    
    var name: String {
        return movie.Title
    }
    
    var movieYear: String {
        return movie.Year
    }
    
    var imageUrl: String {
        return movie.Poster
    }

}
