//
//  MovieDetailViewController.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 24/01/2022.
//

import Foundation
import UIKit
class MovieDetailViewController: UIViewController{
   
    private var movieDetailViewModel: MovieDetailViewModelType
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Init(nibName) not implemented" )
    }
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) not implemented")
    }
    init(movieDetailViewModel: MovieDetailViewModelType){
        
        self.movieDetailViewModel = movieDetailViewModel
        super.init(nibName: "\(MovieDetailViewController.self)", bundle: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = self.movieDetailViewModel.title
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.movieDetailViewModel.viewWillDisappear()
    }
    private func setupViewModel(){
        self.movieDetailViewModel.viewDidLoad()
        self.movieDetailViewModel.didLoad = { [weak self] in
            self?.viewModelDidload()
            
        }
    }
    
    private func viewModelDidload(){
        
    }

}

extension MovieDetailViewController: StoryboardInstantiate{
    
    static var defaultStoryboardName: String = "MovieDetail"
}



