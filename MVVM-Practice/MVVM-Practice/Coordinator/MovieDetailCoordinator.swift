//
//  MovieListDetailCoordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 25/01/2022.
//

import UIKit
typealias MovieDetailCoordinatorType = Coordinator
final class MovieDetailCoordinator: MovieDetailCoordinatorType{
    
    private weak var parentCoordinator: Coordinator?
    private weak var navigationController: UINavigationController?
    private(set) var childCordinators: [Coordinator] = []
    private var moviedetailViewModel: MovieDetailViewModelType?
    private var movie: Movie
    
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator, movieModel: Movie){
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.movie = movieModel
  
    }
    
    func start() {
        // objectNo 1
        let container = MovieDetailListContainer()
        container.delegate = self
        let movieListViewController = container.makeMovieDetailListViewController(coordinator: self, movie: self.movie)
        self.moviedetailViewModel = container.getMovieDetailViewModelProtocol()
       
        self.navigationController?.pushViewController(movieListViewController, animated: true)
    }
    
   private func childDidFinish() {
        self.parentCoordinator?.childDidFinish(coordinator: self)
    }
    private  func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
   
}
extension MovieDetailCoordinator: MovieDetailNavigationEvents{
    func viewWillDisappear() {
        self.childDidFinish()
        self.navigateBack()
    }
}


