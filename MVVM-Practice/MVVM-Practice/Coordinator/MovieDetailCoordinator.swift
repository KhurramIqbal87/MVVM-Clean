//
//  MovieListDetailCoordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 25/01/2022.
//

import UIKit



final class MovieDetailCoordinator: Coordinator{
    
    private weak var parentCoordinator: Coordinator?
    private weak var navigationController: UINavigationController?
    private(set) var childCordinators: [Coordinator] = []
    private var moviedetailViewModel: MovieDetailViewModelProtocol
    
    
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator, movieDetailViewModel: MovieDetailViewModelProtocol){
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.moviedetailViewModel = movieDetailViewModel
    }
    
    func start() {
        // objectNo 1
        let container = MovieDetailListContainer()
        let movieListViewController = container.makeMovieDetailListViewController(coordinator: self)
        
        if let viewModel = container.getMovieDetailViewModelProtocol() as? DefaultMovieDetailViewModel{
            viewModel.setCoordinator(coordinator: self)
        }
        self.navigationController?.setViewControllers([movieListViewController], animated: true)
    }
    
    func childDidFinish() {
        self.parentCoordinator?.childDidFinish(coordinator: self)
    }
    func getMovieDetailViewModel()-> MovieDetailViewModelProtocol{
        return self.moviedetailViewModel
    }
   
}



