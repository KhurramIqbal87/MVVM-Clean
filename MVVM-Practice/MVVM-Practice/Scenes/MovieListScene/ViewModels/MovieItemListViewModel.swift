//
//  DefaultMovieListViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation
import UIKit
class MovieItemListViewModel: MovieItemListViewModelType{
  
    var cellReusableIdentifier: String = "\(MovieItemTableViewCell.self)"
    var rating: Double?
    var title: String?
    var releaseDate: String = ""
    var posterImage: String = ""
    private var imageData: Data?
    
    var genreNames: [String] = []
    
    func getFormattedReleaseDate() -> String {
        return "Release Date: \(self.releaseDate)"
    }
   
    func getRatings() -> String {
        return "Ratings: \(self.rating ?? 0.0)"
    }
    func getTitle() -> String {
        return "Title: \(self.title ?? "")"
    }
    func getImage(width: Float, completion: @escaping ((Data?) -> Void)) {
        if let data = self.imageData {
            completion(data)
            return
        }
        if self.posterImage.isEmpty{return}
        self.getImage(relativePath: self.posterImage, width: width) { [weak self] imageData in
            self?.imageData = imageData
            completion(imageData)
        }
    }
    
}
extension MovieItemListViewModel{
    static func convertModelsToViewModels(movies: [Movie])->[MovieItemListViewModel]{
      
        return movies.compactMap { movie in
            let itemListViewModel = MovieItemListViewModel()
            itemListViewModel.genreNames = []
            itemListViewModel.releaseDate = movie.release_date ?? ""
            itemListViewModel.posterImage = movie.poster_path ?? ""
            itemListViewModel.title = movie.title
            itemListViewModel.rating = movie.vote_average
            return itemListViewModel
        }
    }
}
