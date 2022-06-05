//
//  MovieDetailViewController.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 24/01/2022.
//

import Foundation
import UIKit
final class MovieDetailViewController: UIViewController{
   
    private let movieDetailViewModel: MovieDetailViewModelType
  
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
    init(movieDetailViewModel: inout MovieDetailViewModelType){
        
        self.movieDetailViewModel = movieDetailViewModel
        super.init(nibName: "\(MovieDetailViewController.self)", bundle: nil)
        movieDetailViewModel.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.movieDetailViewModel.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.movieDetailViewModel.viewWillDisappear()
    }
   
    private func setupViewModel(){
        self.movieDetailViewModel.viewDidLoad()
    
    }
    
    private func viewModelDidload(){
        
    }

}

extension MovieDetailViewController: StoryboardInstantiate{
    
    static var defaultStoryboardName: String = "MovieDetail"
}

extension MovieDetailViewController : MovieDetailViewModelOutput{
    func getTitle(title: String) {
        self.title = title
    }
    func updateUI() {
        self.viewModelDidload()
    }
}


