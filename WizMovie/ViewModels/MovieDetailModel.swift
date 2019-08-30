//
//  MovieDetailModel.swift
//  WizMovie
//
//  Created by Admin on 8/29/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

class MovieDetailModel: Codable {
    
    private let movieDetail: MovieDetails
    
    init(movieDetail: MovieDetails) {
        self.movieDetail = movieDetail
    }
    
    var name: String {
        return movieDetail.title
    }
    
    var movieYear: String {
        return movieDetail.year
    }
    
    var imageUrl: String {
        return movieDetail.poster
    }
    
    var actor: String {
        return movieDetail.actor
    }
    
    var director: String {
        return movieDetail.director
    }
    
    var genre: String {
        return movieDetail.genre
    }
    
    var imdbRating: String{
        return movieDetail.imdbRating
    }
}
