//
//  MovieListCoordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 24/01/2022.
//

import UIKit

protocol MovieListCoordinatorProtocol: Coordinator{
    func navigateToDetailController(movie: Movie)
}

final class MovieListCoordinator: MovieListCoordinatorProtocol{
    
    private weak var parentCoordinator: Coordinator?
    private weak var navigationController: UINavigationController?
    private(set) var childCordinators: [Coordinator] = []
    
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator){
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
       
    }
    
    func start() {
        // objectNo 1
        let container = MovieListContainer()
        container.delegate = self
        let movieListViewController = container.makeMovieListViewController(coordinator: self)
        self.navigationController?.setViewControllers([movieListViewController], animated: true)
    }
    
    func childDidFinish(coordinator: Coordinator) {
        
        self.parentCoordinator?.childDidFinish(coordinator: self)
        self.childCordinators.removeAll { childCordinator in
            return childCordinator === coordinator
        }
    }
    func navigateToDetailController(movie: Movie){
      
        let coordinator = MovieDetailCoordinator.init(navigationController: self.navigationController ?? UINavigationController(), parentCoordinator: self, movieModel: movie)
        self.childCordinators.append(coordinator)
        coordinator.start()
        
    }
}
extension MovieListCoordinator: MovieListNavigationEvents{
    func navigateToDetail(movie: Movie) {
        self.navigateToDetailController(movie: movie)
    }
}
