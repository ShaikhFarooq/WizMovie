//
//  RequestUrl.swift
//  WizMovie
//
//  Created by Admin on 8/25/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

enum APIKey: String {
    case ApiKey = "&apikey=99ff421"
}

enum EndPoints {
    case Search
    case Title
}

extension EndPoints {
    var path:String {
        let baseURL = "https://www.omdbapi.com/"
        struct Section {
            static let search = "?s="
            static let title = "?t="
        }
        switch(self) {
        case .Search:
            return "\(baseURL)\(Section.search)"
        case .Title:
            return "\(baseURL)\(Section.title)"

        }
    }
}


