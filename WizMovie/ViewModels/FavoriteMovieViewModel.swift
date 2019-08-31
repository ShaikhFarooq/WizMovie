//
//  FavoriteMovieViewModel.swift
//  WizMovie
//
//  Created by Admin on 8/31/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMovieViewModel{
    
    //MARK: - Properties
    var favoriteMovieArray = [MovieDetailModel]()
    var favMovieTable = UITableView()
    var view = UIView()
    var errorLbl = UILabel()
    
    //MARK: - Get all movies from local storage
    public func getMoviesFromLocalStorage() -> [MovieDetailModel]?{
        if let movieSaveArray = MovieUserDefaults.getMovieInfo(){
            favoriteMovieArray = movieSaveArray
        }
        return favoriteMovieArray
    }
    
    // MARK: - To send each cell data using index
    public func getFavoriteCellViewModel(index: Int) -> MovieDetailModel? {
        let favoriteMovieArrays = favoriteMovieArray.sorted { $0.name < $1.name }
        let favMovieTableViewCellModel = favoriteMovieArrays[index]
        return favMovieTableViewCellModel
    }
    
    // MARK: - Count of favorite movies to be shown
    public var count: Int {
        return favoriteMovieArray.count
    }
    
    //MARK: - To added lable
    public func addErrorLable(windowView: UIView,tableView: UITableView,message: String){
        view = windowView
        favMovieTable = tableView
        errorLbl = UILabel(frame: CGRect(x:windowView.frame.size.width/2 , y: windowView.frame.size.width/2, width: windowView.frame.size.width-50, height: 50))
        errorLbl.text = message
        errorLbl.myLabel()
        view.addSubview(errorLbl)
        errorLbl.translatesAutoresizingMaskIntoConstraints = false
        errorLbl.widthAnchor.constraint(equalTo: windowView.widthAnchor).isActive = true
        errorLbl.heightAnchor.constraint(equalTo: windowView.heightAnchor).isActive = true
        errorLbl.centerXAnchor.constraint(equalTo: windowView.centerXAnchor).isActive = true
        errorLbl.centerYAnchor.constraint(equalTo: windowView.centerYAnchor).isActive = true
        errorLbl.isHidden = true
    }
    
    // MARK: - To show error messages
    public func showErrorMessage(){
        errorLbl.isHidden = false
        errorLbl.setNeedsDisplay()
    }
    
    // MARK: - To hide error messages
    public func hideErrorMessage(){
        for v in view.subviews{
            if v is UILabel{
                v.removeFromSuperview()
            }else{
                print("no label bro")
            }
        }
    }
}

