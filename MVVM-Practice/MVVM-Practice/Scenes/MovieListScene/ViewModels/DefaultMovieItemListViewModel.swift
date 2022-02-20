//
//  DefaultMovieListViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation
import UIKit
class DefaultMovieItemListViewModel: MovieItemListViewModelProtocol{
    var coordinator: Coordinator?
    var cellReusableIdentifier: String = ""
    var rating: Double?
    var title: String?
    var releaseDate: String = ""
    
    var imageData: Data?
    
    var genreNames: [String] = []
    
    func getFormattedReleaseDate() -> String {
        return self.releaseDate
    }
   
    func getRatings() -> String {
        return "\(self.rating ?? 0.0)"
    }
    
    func getImage(completion: @escaping ((Data?) -> Void)) {
        
    }
    func setCoordinator(coordinator: Coordinator){
        self.coordinator = coordinator
    }
    
    static func convertModelsToViewModels(movies: [Movie])->[DefaultMovieItemListViewModel]{
      
        return movies.compactMap { movie in
            let itemListViewModel = DefaultMovieItemListViewModel()
            itemListViewModel.genreNames = movie.genre_ids.map({ genre in
                return genre.name
            })
            itemListViewModel.releaseDate = movie.release_date
            return itemListViewModel
        }
    }
    
}
