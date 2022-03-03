//
//  AppContainer.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 17/11/2021.
//

import Foundation

import UIKit
class MovieListContainer{
    private  var resolver: Container?
    init() {
        resolver = Container()
    }
    func makeMovieListViewController(coordinator: MovieListCoordinatorProtocol)->UIViewController {
        
        self.makeMovieListViewModel(coordinator: coordinator)
        
        resolver = resolver?.register(Coordinator.self, { _ in
            return coordinator
        })
        let viewController:MovieListViewController = MovieListViewController.instantiate(nil, resolver: resolver)
        if let viewModel = self.getMovieListViewModelProtocol(){
            
            viewController.setupViewModel(viewModel: viewModel)
        }
       
        return viewController
        
    }
    
    private func makeMovieListViewModel(coordinator: MovieListCoordinatorProtocol){
        
        self.makeMovieListRepository()
        guard let resolver = self.resolver else{return}
        self.resolver =  resolver.register(MovieListViewModelProtocol.self) { resolver in
            return DefaultMovieListViewModel.init(repository: try! resolver.resolve(type: MovieListImageRepositoryProtocol.self), coordinator: coordinator)
        }
    }
    
     private func makeMovieListRepository(){
        self.makeNetworkManager()
        guard let resolver = self.resolver else{return}
        self.resolver = resolver.register(MovieListImageRepositoryProtocol.self) { resolver in
            return DefaultMovieListRepository.init(networkManager: try! resolver.resolve(type: NetworkProtocol.self))
        }
        
    }
    
    private  func makeNetworkManager(){
        guard let resolver = self.resolver else{return}
        self.resolver =  resolver.register(interface: NetworkProtocol.self, instance: NetworkManager.sharedInstance)
        
    }
    
   private func makeDatabaseManager(){
        
    }
     func getMovieListViewModelProtocol()->MovieListViewModelProtocol?{
        return try? self.resolver?.resolve(type: MovieListViewModelProtocol.self)
    }
   
}


