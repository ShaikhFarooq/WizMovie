//
//  MovieDetailViewController.swift
//  WizMovie
//
//  Created by Admin on 8/29/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieYearLbl: UILabel!
    @IBOutlet weak var movieDirectorLbl: UILabel!
    @IBOutlet weak var movieActorLbl: UILabel!
    @IBOutlet weak var moviePosterImgView: UIImageView!
    @IBOutlet weak var imdbRatingLbl: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    //MARK: Properties
    public var viewModel: MovieDetailModel?
    var favBtnIsSelected = false
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setData()
        checkMovieIsInFavoriteList()
    }
    
    //MARK: Binding Data to UI
    func setData(){
        guard let vm = viewModel else {
            return
        }
        self.navigationItem.title = vm.name
        movieNameLbl.text = vm.name
        movieYearLbl.text = "Year : \(vm.movieYear)"
        movieDirectorLbl.text = "Director : \(vm.director)"
        movieActorLbl.text = "Actor : \(vm.actor)"
        imdbRatingLbl.text = "Rated : \(vm.imdbRating)"
        moviePosterImgView.setImage(fromURL: URL(string: vm.imageUrl)!)
    }
    
    func checkMovieIsInFavoriteList(){
        guard let vm = viewModel else {
            return
        }
        var favMovieArray = [MovieDetailModel]()
        if let movieSaveArray = MovieUserDefaults.getMovieInfo(){
            favMovieArray = movieSaveArray
            if favMovieArray.contains(where: {($0.name == vm.name)}){
                favoriteBtn.setImage(#imageLiteral(resourceName: "favIcon"), for: .normal)
                favBtnIsSelected = false
            }else{
                favoriteBtn.setImage(#imageLiteral(resourceName: "unfavIcon"), for: .normal)
                favBtnIsSelected = true
            }
        }else{
            favoriteBtn.setImage(#imageLiteral(resourceName: "unfavIcon"), for: .normal)
            favBtnIsSelected = true
        }
    }
    
    //MARK: - User Interaction Methods
    func favoriteBtnTappedAction(){
//        favBtnIsSelected = !favBtnIsSelected
        guard let vm = viewModel else {
            return
        }
        checkMovieIsInFavoriteList()
        if favBtnIsSelected == true {
            favoriteBtn.setImage(#imageLiteral(resourceName: "favIcon"), for: .normal)
            var favMovieArray = [MovieDetailModel]()
            if let movieSaveArray = MovieUserDefaults.getMovieInfo(){
                favMovieArray = movieSaveArray
                if !favMovieArray.contains(where: {($0.name == vm.name)}){
                    favMovieArray.append(vm)
                    MovieUserDefaults.setMovieInfo(favMovieArray)
                }
            }else{
                favMovieArray.append(vm)
                MovieUserDefaults.setMovieInfo(favMovieArray)
            }
            
        } else if favBtnIsSelected == false {
            favoriteBtn.setImage(#imageLiteral(resourceName: "unfavIcon"), for: .normal)
            var favMovieArray = [MovieDetailModel]()
            if let movieSaveArray = MovieUserDefaults.getMovieInfo(){
                favMovieArray = movieSaveArray
                if favMovieArray.contains(where: {($0.name == vm.name)}){
                    favMovieArray = favMovieArray.filter { $0.name != vm.name }
                    print(favMovieArray)
                    MovieUserDefaults.setMovieInfo(favMovieArray)
                }
            }
        }
       
        // Just to check whether data is getting saved or not
        if let movieSaveArrays = MovieUserDefaults.getMovieInfo(){
            for m in movieSaveArrays{
                print(m.name)
            }
        }else{
            print("Something went wrong could not save data to user defaults")
        }
    }
    
    //MARK: User Interaction Methods
    @IBAction func favoriteBtnTapped(_ sender: Any) {
       favoriteBtnTappedAction()
    }
    
    @IBAction func shareBtnTapped(_ sender: Any) {
        guard let vm = viewModel else {
            return
        }
        let mailSubject = "Movie detail of \(vm.name)"
        let messageTosend = """
        Movie Name : \(vm.name),
        Year : \(vm.movieYear),
        Actor : \(vm.actor),
        Rated : \(vm.imdbRating),
        Poster : \(vm.imageUrl)
        """
        
        // set up activity view controller
        let textToShare = [messageTosend]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.postToWeibo,  UIActivity.ActivityType.print, UIActivity.ActivityType.copyToPasteboard,UIActivity.ActivityType.assignToContact,UIActivity.ActivityType.saveToCameraRoll,UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToFlickr, UIActivity.ActivityType.postToVimeo,UIActivity.ActivityType.postToTencentWeibo,UIActivity.ActivityType.airDrop]
        activityViewController.setValue(mailSubject, forKey: "Subject")
        self.present(activityViewController, animated: true, completion: nil)
    }
}
