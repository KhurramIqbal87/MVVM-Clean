//
//  MovieListDetailCoordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 25/01/2022.
//

import UIKit

final class MovieDetailCoordinator: MovieDetailCoordinatorProtocol{
    
    private weak var parentCoordinator: Coordinator?
    private weak var navigationController: UINavigationController?
    private(set) var childCordinators: [Coordinator] = []
    private var moviedetailViewModel: MovieDetailViewModelProtocol?
    private var movie: Movie
    
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator, movieModel: Movie){
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.movie = movieModel
  
    }
    
    func start() {
        // objectNo 1
        let container = MovieDetailListContainer()
        let movieListViewController = container.makeMovieDetailListViewController(coordinator: self, movie: self.movie)
        self.moviedetailViewModel = container.getMovieDetailViewModelProtocol()
       
        self.navigationController?.setViewControllers([movieListViewController], animated: true)
    }
    
    func childDidFinish() {
        self.parentCoordinator?.childDidFinish(coordinator: self)
    }
    func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
   
   
}

protocol MovieDetailCoordinatorProtocol: Coordinator {
    
    func navigateBack()
}


