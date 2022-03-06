//
//  MovieDetailListContainer.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 17/11/2021.
//

import Foundation

import UIKit
class MovieDetailListContainer{
    private  var resolver: Container?
    init() {
        resolver = Container()
    }
    func makeMovieDetailListViewController(coordinator: MovieDetailCoordinatorProtocol, movie: Movie)->UIViewController {
        
        self.makeMovieDetailViewModel(coordinator: coordinator, movie: movie)
        
        resolver = resolver?.register(Coordinator.self, { _ in
            return coordinator
        })
        let viewController: MovieDetailViewController = MovieDetailViewController.instantiate(nil, resolver: resolver)
        if let moviedDetailVM = self.getMovieDetailViewModelProtocol(){
            viewController.setViewModel(viewModel: moviedDetailVM)
        }
        return viewController
        
    }
    
    private func makeMovieDetailViewModel(coordinator: MovieDetailCoordinatorProtocol, movie: Movie){
        
        self.makeMovieDetailRepository()
        guard let resolver = self.resolver else{return}
        self.resolver =  resolver.register(MovieDetailViewModelProtocol.self) { resolver in
            return DefaultMovieDetailViewModel.init(coordinator: coordinator, repository: try! resolver.resolve(type: MovieDetailImageRepositoryProtocol.self), movie: movie)
        }
    }
    
     private func makeMovieDetailRepository(){
        self.makeNetworkManager()
        guard let resolver = self.resolver else{return}
        self.resolver = resolver.register(MovieDetailImageRepositoryProtocol.self) { resolver in
            return DefaultMovieDetailRepository.init(networkManager: try! resolver.resolve(type: NetworkProtocol.self))
        }
        
    }
    
    private  func makeNetworkManager(){
        guard let resolver = self.resolver else{return}
        self.resolver =  resolver.register(interface: NetworkProtocol.self, instance: NetworkManager.sharedInstance)
        
    }
    
    private func makeDatabaseManager(){
        
    }
    
    func getMovieDetailViewModelProtocol()->MovieDetailViewModelProtocol?{
        return try? self.resolver?.resolve(type: MovieDetailViewModelProtocol.self)
    }
   
}


