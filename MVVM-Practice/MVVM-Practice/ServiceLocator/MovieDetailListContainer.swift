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
    weak var delegate: MovieDetailNavigationEvents?
    init() {
        resolver = Container()
    }
    func makeMovieDetailListViewController( movie: Movie)->UIViewController {
        
        self.makeMovieDetailViewModel( movie: movie)
        
        
        guard let moviedDetailVM = self.getMovieDetailViewModelProtocol() else {
            return UIViewController()
        }
        
        
        let viewController = MovieDetailViewController.init(movieDetailViewModel: moviedDetailVM)
        if let vm = moviedDetailVM as? MovieDetailViewModel{
            vm.naviagtionEventDelegate = self
        }
        return viewController
        
    }
    
    private func makeMovieDetailViewModel( movie: Movie){
        
        self.makeMovieDetailRepository()
        guard let resolver = self.resolver else{return}
        self.resolver =  resolver.register(MovieDetailViewModelType.self) {  resolver in
            let viewModel =  MovieDetailViewModel.init( repository: try! resolver.resolve(type: MovieDetailImageRepositoryType.self), movie: movie)
            return viewModel
        }
    }
    
     private func makeMovieDetailRepository(){
        self.makeNetworkManager()
        guard let resolver = self.resolver else{return}
        self.resolver = resolver.register(MovieDetailImageRepositoryType.self) { resolver in
            return DefaultMovieDetailRepository.init(networkManager: try! resolver.resolve(type: NetworkProtocol.self))
        }
        
    }
    
    private  func makeNetworkManager(){
        guard let resolver = self.resolver else{return}
        self.resolver =  resolver.register(interface: NetworkProtocol.self, instance: NetworkManager.sharedInstance)
        
    }
    
    private func makeDatabaseManager(){
        
    }
    
    func getMovieDetailViewModelProtocol()->MovieDetailViewModelType?{
        return try? self.resolver?.resolve(type: MovieDetailViewModelType.self)
    }
   
}


extension MovieDetailListContainer: MovieDetailNavigationEvents{
    func viewWillDisappear() {
        self.delegate?.viewWillDisappear()
    }
}
