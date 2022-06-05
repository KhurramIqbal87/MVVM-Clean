//
//  MovieListDetailCoordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 25/01/2022.
//

import UIKit
typealias MovieDetailCoordinatorType = Coordinator
final class MovieDetailCoordinator: MovieDetailCoordinatorType{
   
    func childDidFinish(coordinator: Coordinator) {
        
    }
    
    
    private weak var parentCoordinator: Coordinator?
    private var container: MovieDetailListContainer?
    private weak var navigationController: UINavigationController?
    private(set) var childCordinators: [Coordinator] = []
    private var movie: Movie
    
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator, movieModel: Movie){
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.movie = movieModel
  
    }
    
    func start() {
        // objectNo 1
        container = MovieDetailListContainer()
        container?.delegate = self
        if  let movieListViewController = container?.makeMovieDetailListViewController( movie: self.movie){
         
       
        self.navigationController?.pushViewController(movieListViewController, animated: true)
        }
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
        self.container = nil
        
        self.childDidFinish()
        self.navigateBack()
    }
}


