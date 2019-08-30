//
//  MovieUserDefaults.swift
//  WizMovie
//
//  Created by Admin on 8/30/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

class MovieUserDefaults: NSObject {
    
    static let kMovieInfo = "kMovieInfo"
    static let movieUserDefaults = UserDefaults.standard

    class func setMovieInfo(_ info: [MovieDetailModel]) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(info) {
            movieUserDefaults.set(encoded, forKey: kMovieInfo)
        }
    }

    class func getMovieInfo() -> [MovieDetailModel]?{
        
        if let savedMovie = movieUserDefaults.object(forKey: kMovieInfo) as? Data {
            let decoder = JSONDecoder()
            if let loadedMovie = try? decoder.decode(Array<MovieDetailModel>.self, from: savedMovie) {
                return loadedMovie
            }
        }
        return nil
    }
}
