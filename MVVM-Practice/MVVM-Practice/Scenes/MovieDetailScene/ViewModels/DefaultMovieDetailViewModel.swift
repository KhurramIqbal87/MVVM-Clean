//
//  MovieCastViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 28/02/2022.
//

import Foundation
import UIKit
final class DefaultMovieDetailViewModel: MovieDetailViewModelProtocol{
    
    
    private var cast: [MovieCastViewModel] = []
    
    private var crew: [MovieCrewViewModel] = []
    private var genres: [GenreViewModel] = []
    
    var releaseDate: String = ""
    var overview: String = ""
    var imagePath: String = ""
    var title: String = ""
    var genre: [String] = []
    var didLoad: (() -> Void)?
    var id: Int = 0

    private  var coordinator: MovieDetailCoordinatorProtocol
    private var repository: MovieDetailImageRepositoryProtocol
    
    init(coordinator: MovieDetailCoordinatorProtocol, repository: MovieDetailImageRepositoryProtocol, movie: Movie){
        self.coordinator = coordinator
        self.repository =  repository
        self.title = movie.title
        self.releaseDate = movie.release_date
        self.imagePath = movie.poster_path
        self.overview = movie.overview
        self.id = Int(movie.id)
    }
    //MARK: - View Life Cycle calls
    func viewDidLoad() {
       
        self.getGenre { [weak self ] genres in
            self?.setGenre(genre: genres)
            self?.getMovieCredits()
        }
    }
    private func setGenre(genre: [Genre]){
        self.genres = genre.compactMap({ genre in
            return GenreViewModel.init(genre: genre)
        })
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
    func getCrew() -> [MovieCrewViewModelProtocol] {
        return self.crew
    }
    
    
    func getCast() -> [MoiveCastViewModelProtocol] {
        return self.cast
    }
    func getGenre() -> [GenreViewModelProtocol] {
        return self.genres
    }
}
extension DefaultMovieDetailViewModel{
    
    private func getMovieCredits(){
        self.repository.getMovieCredits(movieID: self.id, completion: { [weak self] movieCredit in
            guard let credit = movieCredit else{return}
            self?.setCredits(credit: credit)
            self?.didLoad?()
        })
    }
    
    private func setCredits(credit: MovieCredit){
        
        self.crew =  credit.crew.compactMap { crewModel in
            MovieCrewViewModel.convertModelToViewModel(crew: crewModel)
        }
        self.cast =  credit.cast.compactMap { castModel in
            MovieCastViewModel.convertModelToViewModel(cast: castModel)
        }
        
    }
    private func getGenre(completion: @escaping((_ genres: [Genre])->Void)){
        
        self.repository.getGenre { genres in
            completion(genres)
        }
    }
}
extension DefaultMovieDetailViewModel{
    static func convertModelToViewModel(movie: Movie, coordinator: MovieDetailCoordinatorProtocol, repository: MovieDetailImageRepositoryProtocol)->DefaultMovieDetailViewModel{
      
        
        let movieDetailViewModel = DefaultMovieDetailViewModel(coordinator: coordinator, repository: repository, movie: movie)
        movieDetailViewModel.genre = []
        movieDetailViewModel.releaseDate = movie.release_date
        movieDetailViewModel.imagePath = movie.poster_path
        movieDetailViewModel.overview = movie.overview
        movieDetailViewModel.title = movie.title
        movieDetailViewModel.id = Int(movie.id)
        
        return movieDetailViewModel
        
    }
}
