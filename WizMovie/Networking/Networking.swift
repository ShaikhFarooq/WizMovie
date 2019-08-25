//
//  Networking.swift
//  WizMovie
//
//  Created by Admin on 8/25/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation
import Alamofire

class Network{
    
    // MARK: - Singleton
    static let shared = Network()
    
    // MARK: - Network/API Request
    func searchMoviesOnJson<T: Codable>(urlByName: String,type: T.Type, completionHandler: ((_ response: T?,_ Success: String,Error?) -> Void)?) {
        
        //returns a list of movies that contains the title searched
        Alamofire.request(urlByName).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let moviesJSON = value as! NSDictionary
                let response = moviesJSON.value(forKey: "Response")! as! NSString
                print(response.boolValue)
                if response.boolValue{
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: moviesJSON, options: .prettyPrinted)
                        let reqJSONStr = String(data: jsonData, encoding: .utf8)
                        let data = reqJSONStr?.data(using: .utf8)
                        let response = Response(data: data!)
                        guard let decoded = response.decode(type) else {
                            return
                        }
                        completionHandler?(decoded,"True", nil)
                    }catch{
                        print(error)
                    }
                }else{
                    completionHandler?(nil,"False",NSError(domain: "No Movie", code: -101, userInfo: nil))
                }
                
            case .failure(let err):
                completionHandler?(nil,"False",err)
            }
        }
    }
}

