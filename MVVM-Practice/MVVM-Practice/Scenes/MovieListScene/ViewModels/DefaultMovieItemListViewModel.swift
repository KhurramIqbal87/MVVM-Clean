//
//  DefaultMovieListViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation
import UIKit
class DefaultMovieItemListViewModel: MovieItemListViewModelProtocol{
  
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
       
        self.getImage(relativePath: self.posterImage) { imageData in
            completion(imageData)
        }
    }
    
}
extension DefaultMovieItemListViewModel{
    static func convertModelsToViewModels(movies: [Movie])->[DefaultMovieItemListViewModel]{
      
        return movies.compactMap { movie in
            let itemListViewModel = DefaultMovieItemListViewModel()
            itemListViewModel.genreNames = []
            itemListViewModel.releaseDate = movie.release_date
            itemListViewModel.posterImage = movie.poster_path
            itemListViewModel.title = movie.title
            itemListViewModel.rating = movie.vote_average
            return itemListViewModel
        }
    }
}
