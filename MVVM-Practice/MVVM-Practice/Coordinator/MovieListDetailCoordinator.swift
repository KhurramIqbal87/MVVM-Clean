//
//  MovieListDetailCoordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 25/01/2022.
//

import UIKit



final class MovieListDetailCoordinator: Coordinator{
    
    private weak var parentCoordinator: Coordinator?
    private weak var navigationController: UINavigationController?
    private(set) var childCordinators: [Coordinator] = []
    private var moviedetailViewModel: MovieItemListViewModelProtocol
    
    
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator, movieDetailViewModel: MovieItemListViewModelProtocol){
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.moviedetailViewModel = movieDetailViewModel
    }
    
    func start() {
        // objectNo 1
        let container = MovieListContainer()
        let movieListViewController = container.makeMovieListViewController(coordinator: self)
        
        if let viewModel = container.getMovieListViewModelProtocol() as? DefaultMovieListViewModel{
            viewModel.setCoordinator(coordinator: self)
        }
        self.navigationController?.setViewControllers([movieListViewController], animated: true)
    }
    
    func childDidFinish() {
        self.parentCoordinator?.childDidFinish(coordinator: self)
    }
   
}



