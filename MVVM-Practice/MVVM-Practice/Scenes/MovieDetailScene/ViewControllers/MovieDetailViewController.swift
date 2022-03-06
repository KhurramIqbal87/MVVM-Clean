//
//  MovieListViewController.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 24/01/2022.
//

import Foundation
import UIKit
class MovieDetailViewController: UIViewController{
   
   private var movieDetailViewModel: MovieDetailViewModelProtocol?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = self.movieDetailViewModel?.title
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.movieDetailViewModel?.viewWillDisappear()
    }
    private func setupViewModel(){
        self.movieDetailViewModel?.viewDidLoad()
        
        self.movieDetailViewModel?.didLoad = self.viewModelDidLoad
    }
    func setViewModel(viewModel: MovieDetailViewModelProtocol){
        self.movieDetailViewModel = viewModel
    }
    
    func viewModelDidLoad(){
     
    }
}

extension MovieDetailViewController: StoryboardInstantiate{
    
    static var defaultStoryboardName: String = "MovieDetail"
}



