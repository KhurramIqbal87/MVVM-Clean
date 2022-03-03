//
//  MovieCastViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 28/02/2022.
//

import Foundation
import UIKit
final class DefaultMovieDetailViewModel: MovieDetailViewModelProtocol{
    var cast: [MovieCastModel] = []
    
    var crew: [MovieCrewModel] = []
    
    var releaseDate: String = ""
    var overview: String = ""
    var imagePath: String = ""
    var title: String = ""
    var genre: [String] = []
    var didLoad: (() -> Void)?
    var id: Int = 0

    private  var coordinator: MovieDetailCoordinatorProtocol
    private var repository: MovieDetailImageRepositoryProtocol
    
    init(coordinator: MovieDetailCoordinatorProtocol, repository: MovieDetailImageRepositoryProtocol){
        self.coordinator = coordinator
        self.repository =  repository
    }
    //MARK: - View Life Cycle calls
    func viewDidLoad() {
        self.getMovieCredits()
    }
    
    func viewWillDisappear() {
        coordinator.childDidFinish(coordinator: coordinator)
        
    }
   //MARK: - Protocol Functions
    func getImage(imagePath: String, compeletion: @escaping ((Data) -> Void)) {
        self.repository.getImage(relativePath: imagePath, completion: { imageData in
            
            if let data = imageData{
                compeletion(data)
            }
            
        })
    }
    func navigateBack() {
        self.coordinator.navigateBack()
    }
}
extension DefaultMovieDetailViewModel{
    
    func getMovieCredits(){
        self.repository.getMovieCredits(movieID: self.id, completion: { [weak self] movieCredit in
            
            self?.didLoad?()
        })
    }
}
extension DefaultMovieDetailViewModel{
    static func convertModelToViewModel(movie: Movie, coordinator: MovieDetailCoordinatorProtocol, repository: MovieDetailImageRepositoryProtocol)->DefaultMovieDetailViewModel{
      
        
        let movieDetailViewModel = DefaultMovieDetailViewModel(coordinator: coordinator, repository: repository)
        movieDetailViewModel.genre = []
        movieDetailViewModel.releaseDate = movie.release_date
        movieDetailViewModel.imagePath = movie.poster_path
        movieDetailViewModel.overview = movie.overview
        movieDetailViewModel.title = movie.title
        movieDetailViewModel.id = Int(movie.id)
        
        return movieDetailViewModel
        
    }
}
