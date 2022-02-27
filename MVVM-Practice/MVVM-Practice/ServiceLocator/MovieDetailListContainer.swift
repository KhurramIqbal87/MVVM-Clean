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
    func makeMovieDetailListViewController(coordinator: MovieDetailCoordinator)->UIViewController {
        
        self.makeMovieDetailViewModel()
        
        resolver = resolver?.register(Coordinator.self, { _ in
            return coordinator
        })
        let viewController: MovieDetailViewController = MovieDetailViewController.instantiate(nil, resolver: resolver)
     
        viewController.setViewModel(viewModel: coordinator.getMovieDetailViewModel())
       
        return viewController
        
    }
    
    private func makeMovieDetailViewModel(){
        
        self.makeMovieListRepository()
        guard let resolver = self.resolver else{return}
        self.resolver =  resolver.register(MovieListViewModelProtocol.self) { resolver in
            return DefaultMovieListViewModel.init(repository: try! resolver.resolve(type: MovieListRepositoryProtocol.self))
        }
    }
    
     private func makeMovieListRepository(){
        self.makeNetworkManager()
        guard let resolver = self.resolver else{return}
        self.resolver = resolver.register(MovieListRepositoryProtocol.self) { resolver in
            return DefaultMovieListRepository.init(networkManager: try! resolver.resolve(type: NetworkProtocol.self))
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


