//
//  MovieCastViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 28/02/2022.
//

import Foundation
import UIKit

protocol MovieDetailNavigationEvents: AnyObject{
    func viewWillDisappear()
}
final class MovieDetailViewModel: MovieDetailViewModelType{
    weak var delegate: MovieDetailViewModelOutput?
    
    weak var naviagtionEventDelegate: MovieDetailNavigationEvents?
    private var cast: [MovieCastViewModel] = []
    
    private var crew: [MovieCrewViewModel] = []
    private var genres: [GenreViewModel] = []
    
    var releaseDate: String = ""
    var overview: String = ""
    var imagePath: String = ""
    var title: String = ""
    var didLoad: (() -> Void)?
    var id: Int = 0
  

  
    private var repository: MovieDetailImageRepositoryType
    
    init( repository: MovieDetailImageRepositoryType, movie: Movie){
        
        self.repository =  repository
        self.title = movie.title
        self.releaseDate = movie.release_date ?? ""
        self.imagePath = movie.poster_path ?? ""
        self.overview = movie.overview
        self.id = Int(movie.id)
        self.genres = movie.genre_ids.compactMap({ id in
            return GenreViewModel(id: id)
        })
    }
    //MARK: - View Life Cycle calls
    func viewDidLoad() {
       
        self.getGenre { [weak self ] genres in
            self?.setGenre(genre: genres)
            self?.getMovieCredits()
        }
    }
    func viewWillAppear() {
        self.delegate?.getTitle(title: self.title)
    }
    func viewWillDisappear() {
        self.naviagtionEventDelegate?.viewWillDisappear()
        
    }
    private func setGenre(genre: [Genre]){
       let genres = genre.compactMap({ genreMap in
            return GenreViewModel.init(genre: genreMap)
        })
        
        self.genres = genres.filter { genreFilter in
            return self.genres.contains { genre2 in
                return genre2.id == genreFilter.id
            }
        }
        print(self.genres.count)
    }
    
    
   //MARK: - Protocol Functions
    func getImage(imagePath: String, compeletion: @escaping ((Data) -> Void)) {
        self.repository.getImage(relativePath: imagePath, width: 400, completion: { imageData in
            
            if let data = imageData{
                compeletion(data)
            }
            
        })
    }
    func navigateBack() {
        self.naviagtionEventDelegate?.viewWillDisappear()
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
extension MovieDetailViewModel{
    
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
extension MovieDetailViewModel{
    static func convertModelToViewModel(movie: Movie, coordinator: MovieDetailCoordinatorType, repository: MovieDetailImageRepositoryType)->MovieDetailViewModel{
      
        
        let movieDetailViewModel = MovieDetailViewModel( repository: repository, movie: movie)
        movieDetailViewModel.genres = []
        movieDetailViewModel.releaseDate = movie.release_date ?? ""
        movieDetailViewModel.imagePath = movie.poster_path ?? ""
        movieDetailViewModel.overview = movie.overview
        movieDetailViewModel.title = movie.title
        movieDetailViewModel.id = Int(movie.id)
        
        return movieDetailViewModel
        
    }
}
