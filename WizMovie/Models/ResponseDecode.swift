//
//  ResponseDecode.swift
//  WizMovie
//
//  Created by Admin on 8/25/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

// MARK: - To Decode the model
struct Response {
    fileprivate var data: Data
    init(data: Data) {
        self.data = data
    }
}


extension Response {
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch _ {
            return nil
        }
    }
}
