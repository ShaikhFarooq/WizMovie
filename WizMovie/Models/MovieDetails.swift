//
//  MovieDetails.swift
//  WizMovie
//
//  Created by Admin on 8/29/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

struct MovieDetails: Codable {
    let title: String
    let year: String
    let genre: String
    let director: String
    let writer: String
    let actor: String
    let poster: String
    let imdbRating: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actor = "Actors"
        case poster = "Poster"
        case imdbRating = "imdbRating"
    }
}
