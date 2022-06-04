//
//  AppContainer.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 17/11/2021.
//

import Foundation

import UIKit


protocol  MovieListNavigationEvents: AnyObject{
    func navigateToDetail(movie: Movie)
}
class MovieListContainer{
    public weak var delegate: MovieListNavigationEvents?
    private  var resolver: Container?
    init() {
        resolver = Container()
    }
    func makeMovieListViewController(coordinator: MovieListCoordinatorProtocol)->UIViewController {
        
        self.makeMovieListViewModel(coordinator: coordinator)
        
        resolver = resolver?.register(Coordinator.self, { _ in
            return coordinator
        })
        
        guard let viewModel = self.getMovieListViewModelProtocol()else{
            
            return UIViewController()
        }
        let viewController = MovieListViewController.init(movieListViewModel: viewModel)
        return viewController
    }
    
    private func makeMovieListViewModel(coordinator: MovieListCoordinatorProtocol){
        
        self.makeMovieListRepository()
        guard let resolver = self.resolver else{return}
        self.resolver =  resolver.register(MovieListViewModelType.self) { resolver in
        
            let movieListViewModel =  MovieListViewModel.init(repository: try! resolver.resolve(type: MovieListImageRepositoryType.self))
            movieListViewModel.movieListNavigationDelegate = self
            
            return movieListViewModel
        }
    }
    
     private func makeMovieListRepository(){
        self.makeNetworkManager()
        guard let resolver = self.resolver else{return}
        self.resolver = resolver.register(MovieListImageRepositoryType.self) { resolver in
            return MovieListRepository.init(networkManager: try! resolver.resolve(type: NetworkProtocol.self))
        }
        
    }
    
    private  func makeNetworkManager(){
        guard let resolver = self.resolver else{return}
        self.resolver =  resolver.register(interface: NetworkProtocol.self, instance: NetworkManager.sharedInstance)
        
    }
    
   private func makeDatabaseManager(){
        
    }
     func getMovieListViewModelProtocol()->MovieListViewModelType?{
        return try? self.resolver?.resolve(type: MovieListViewModelType.self)
    }
   
}


extension MovieListContainer: MovieListNavigationEvents{
    func navigateToDetail(movie: Movie) {
        self.delegate?.navigateToDetail(movie: movie)
    }
    
    
}
