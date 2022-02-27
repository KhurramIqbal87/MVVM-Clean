//
//  DefaultMovieListViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation
import UIKit
class DefaultMovieItemListViewModel: MovieItemListViewModelProtocol{
    private var posterImageRepository: PosterImageRepository?
    
    var coordinator: Coordinator?
    var cellReusableIdentifier: String = "\(MovieItemTableViewCell.self)"
    var rating: Double?
    var title: String?
    var releaseDate: String = ""
    var posterImage: String = ""
    
    
    var genreNames: [String] = []
    
    func getFormattedReleaseDate() -> String {
        return self.releaseDate
    }
   
    func getRatings() -> String {
        return "\(self.rating ?? 0.0)"
    }
    
    func getImage(completion: @escaping ((Data?) -> Void)) {
       
        self.posterImageRepository?.getImage(relativePath: self.posterImage, completion: { imageData in
            completion(imageData)
        })
    }
    func setCoordinator(coordinator: Coordinator){
        self.coordinator = coordinator
    }
    func setPosterRepository(repository: PosterImageRepositoryProtocol) {
        self.posterImageRepository = repository as? PosterImageRepository
    }
    
}
extension DefaultMovieItemListViewModel{
    static func convertModelsToViewModels(movies: [Movie])->[DefaultMovieItemListViewModel]{
      
        return movies.compactMap { movie in
            let itemListViewModel = DefaultMovieItemListViewModel()
            itemListViewModel.genreNames = movie.genre_ids.map({ genre in
                return genre.name
            })
            itemListViewModel.releaseDate = movie.release_date
            itemListViewModel.posterImage = movie.poster_path
            return itemListViewModel
        }
    }
}
